import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/atom_feed.dart';
import 'package:webfeed/domain/rss1_feed.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:xml/xml.dart' as xml;

extension SafeParseDateTime on DateTime {
  static DateTime safeParse(String str) {
    try {
      return DateTime.parse(str);
    } catch (_) {
      return null;
    }
  }
}

enum RssVersion {
  RSS1,
  RSS2,
  Atom,
  Unknown,
}

class WebFeed {
  WebFeed({
    @required this.title,
    @required this.description,
    @required this.links,
    @required this.items,
  });

  final String title;
  final String description;
  final List<String> links;
  final List<WebFeedItem> items;

  static WebFeed fromXmlString(String xmlString) {
    final rssVersion = detectRssVersion(xmlString);
    switch (rssVersion) {
      case RssVersion.RSS1:
        final rss1Feed = Rss1Feed.parse(xmlString);
        return WebFeed(
          title: rss1Feed.title,
          description: rss1Feed.description,
          links: [rss1Feed.link],
          items: rss1Feed.items
              .map(
                (item) => WebFeedItem(
                  title: item.title,
                  body: item.description ?? item.dc?.description,
                  updated: SafeParseDateTime.safeParse(item.dc?.date),
                  links: [item.link],
                ),
              )
              .toList(),
        );
        break;
      case RssVersion.RSS2:
        final rss2Feed = RssFeed.parse(xmlString);
        return WebFeed(
          title: rss2Feed.title,
          description: rss2Feed.description,
          links: [rss2Feed.link],
          items: rss2Feed.items
              .map(
                (item) => WebFeedItem(
                  title: item.title,
                  body: item.description ?? item.dc?.description,
                  updated: SafeParseDateTime.safeParse(item.dc?.date),
                ),
              )
              .toList(),
        );
        break;
      case RssVersion.Atom:
        final atomFeed = AtomFeed.parse(xmlString);
        return WebFeed(
          title: atomFeed.title,
          description: atomFeed.subtitle,
          links: atomFeed.links.map((atomLink) => atomLink.href).toList(),
          items: atomFeed.items
              .map(
                (item) => WebFeedItem(
                  title: item.title,
                  body: item.summary,
                  updated: SafeParseDateTime.safeParse(item.updated),
                  links: item.links.map((atomLink) => atomLink.href).toList(),
                ),
              )
              .toList(),
        );
        break;
      case RssVersion.Unknown:
        throw Error.safeToString(
            'Invalid XML String? We cannot detect RSS/Atom version.');
        break;
      default:
        throw Exception('Some error has occured.');
    }
  }

  static Future<WebFeed> fromUrl(String url) async {
    final response = await http.get(url);
    return fromXmlString(response.body);
  }

  static RssVersion detectRssVersion(String xmlString) {
    final xmlDoc = xml.parse(xmlString);
    final rdfRefs = xmlDoc.findAllElements('rdf:RDF');
    final rssRefs = xmlDoc.findAllElements('rss');
    final feedRefs = xmlDoc.findAllElements('feed');

    if (rdfRefs.isNotEmpty) {
      return RssVersion.RSS1;
    } else if (rssRefs.isNotEmpty &&
        rssRefs.first.getAttribute('version').contains('2')) {
      return RssVersion.RSS2;
    } else if (feedRefs.isNotEmpty &&
        feedRefs.first.getAttribute('xmlns').toLowerCase().contains('atom')) {
      return RssVersion.Atom;
    }
    return RssVersion.Unknown;
  }
}

class WebFeedItem {
  WebFeedItem({
    this.title,
    this.body,
    this.links,
    this.updated,
  });

  final String title;
  final String body;
  final List<String> links;
  final DateTime updated;
}
