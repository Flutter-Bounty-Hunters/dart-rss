import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

class WebFeed {
  static WebFeed fromXmlString(String xmlString) {
    final rssVersion = detectRssVersion(xmlString);
    switch (rssVersion) {
      case RssVersion.rss1:
        final rss1Feed = Rss1Feed.parse(xmlString);
        return WebFeed.fromRss1(rss1Feed);
      case RssVersion.rss2:
        final rss2Feed = RssFeed.parse(xmlString);
        return WebFeed.fromRss2(rss2Feed);
      case RssVersion.atom:
        final atomFeed = AtomFeed.parse(xmlString);
        return WebFeed.fromAtom(atomFeed);
      case RssVersion.unknown:
        throw Error.safeToString('Invalid XML String? We cannot detect RSS/Atom version.');
      default:
        throw Exception('Some error has occured.');
    }
  }

  static WebFeed fromRss1(Rss1Feed rss1feed) {
    return WebFeed(
      rssVersion: RssVersion.rss1,
      title: rss1feed.title ?? rss1feed.dc?.title ?? '',
      description: rss1feed.description ?? rss1feed.dc?.description ?? '',
      links: [rss1feed.link],
      items: rss1feed.items
          .map(
            (item) => WebFeedItem(
              title: item.title ?? item.dc?.title ?? '',
              body: item.description ?? item.dc?.description ?? '',
              updated: SafeParseDateTime.safeParse(item.dc?.date),
              links: [item.link],
            ),
          )
          .toList(),
    );
  }

  static WebFeed fromRss2(RssFeed rssFeed) {
    return WebFeed(
      rssVersion: RssVersion.rss2,
      title: rssFeed.title ?? rssFeed.dc?.title ?? '',
      description: rssFeed.description ?? rssFeed.dc?.description ?? '',
      links: [rssFeed.link],
      items: rssFeed.items
          .map(
            (item) => WebFeedItem(
              title: item.title ?? item.dc?.title ?? '',
              body: item.description ?? item.dc?.description ?? '',
              updated: SafeParseDateTime.safeParse(item.pubDate) ?? SafeParseDateTime.safeParse(item.dc?.date),
              links: [item.link],
            ),
          )
          .toList(),
    );
  }

  static WebFeed fromAtom(AtomFeed atomFeed) {
    return WebFeed(
      rssVersion: RssVersion.atom,
      title: atomFeed.title ?? '',
      description: atomFeed.subtitle ?? '',
      links: atomFeed.links.map((atomLink) => atomLink.href).toList(),
      items: atomFeed.items
          .map(
            (item) => WebFeedItem(
              title: item.title ?? '',
              body: item.summary ?? item.content ?? '',
              updated: SafeParseDateTime.safeParse(item.updated) ?? SafeParseDateTime.safeParse(item.published),
              links: item.links.map((atomLink) => atomLink.href).toList(),
            ),
          )
          .toList(),
    );
  }

  static Future<WebFeed> fromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return fromXmlString(response.body);
  }

  static RssVersion detectRssVersion(String xmlString) {
    final xmlDoc = xml.XmlDocument.parse(xmlString);
    final rdfRefs = xmlDoc.findAllElements('rdf:RDF');
    final rssRefs = xmlDoc.findAllElements('rss');
    final feedRefs = xmlDoc.findAllElements('feed');

    bool? ver = false;
    bool? xmlns = false;
    ver = rssRefs.isEmpty ? false : rssRefs.first.getAttribute('version')?.contains('2');
    xmlns = feedRefs.isEmpty ? false : feedRefs.first.getAttribute('xmlns')?.toLowerCase().contains('atom');

    if (rdfRefs.isNotEmpty) {
      return RssVersion.rss1;
    } else if (rssRefs.isNotEmpty && ver != null && ver) {
      return RssVersion.rss2;
    } else if (feedRefs.isNotEmpty && xmlns != null && xmlns) {
      return RssVersion.atom;
    }
    return RssVersion.unknown;
  }

  const WebFeed({
    required this.rssVersion,
    required this.title,
    required this.description,
    required this.links,
    required this.items,
  });

  final RssVersion rssVersion;
  final String title;
  final String description;
  final List<String?> links;
  final List<WebFeedItem> items;

  XmlElement toXml() {
    switch (rssVersion) {
      case RssVersion.rss1:
        return _toRss1Xml();
      case RssVersion.rss2:
        return _toRss2Xml();
      case RssVersion.atom:
        return _toAtomXml();
      case RssVersion.unknown:
        throw Exception("Can't serialize RSS to XML because the RSS version is unknown.");
    }
  }

  XmlElement _toRss1Xml() {
    final rss = xml.XmlElement(
      xml.XmlName("channel"),
    );

    return rss;
  }

  XmlElement _toRss2Xml() {
    final rss = xml.XmlElement(
      xml.XmlName("channel"),
    );

    return rss;
  }

  XmlElement _toAtomXml() {
    final rss = xml.XmlElement(
      xml.XmlName("channel"),
    );

    return rss;
  }
}

class WebFeedItem {
  const WebFeedItem({
    this.title = '',
    this.body = '',
    this.links = const <String>[],
    this.updated,
  });

  final String title;
  final String body;
  final List<String?> links;
  final DateTime? updated;
}

enum RssVersion {
  rss1,
  rss2,
  atom,
  unknown,
}
