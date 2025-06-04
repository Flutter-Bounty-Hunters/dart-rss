import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/domain/rss_category.dart';
import 'package:dart_rss/domain/rss_content.dart';
import 'package:dart_rss/domain/rss_enclosure.dart';
import 'package:dart_rss/domain/rss_item_podcast_index.dart';
import 'package:dart_rss/domain/rss_source.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'package:dart_rss/domain/rss_item_itunes.dart';

class RssItem {
  factory RssItem.parse(XmlElement element) {
    return RssItem(
      title: findElementOrNull(element, 'title')?.innerText,
      description: findElementOrNull(element, 'description')?.innerText,
      link: findElementOrNull(element, 'link')?.innerText,
      categories: element.findElements('category').map((element) => RssCategory.parse(element)).toList(),
      guid: findElementOrNull(element, 'guid')?.innerText,
      pubDate: findElementOrNull(element, 'pubDate')?.innerText,
      author: findElementOrNull(element, 'author')?.innerText,
      comments: findElementOrNull(element, 'comments')?.innerText,
      source: RssSource.parse(findElementOrNull(element, 'source')),
      content: RssContent.parse(findElementOrNull(element, 'content:encoded')),
      media: Media.parse(element),
      enclosure: RssEnclosure.parse(findElementOrNull(element, 'enclosure')),
      dc: DublinCore.parse(element),
      itunes: RssItemItunes.parse(element),
      podcastIndex: RssItemPodcastIndex.parse(element),
    );
  }

  const RssItem({
    this.title,
    this.description,
    this.link,
    this.categories = const <RssCategory>[],
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.source,
    this.content,
    this.media,
    this.enclosure,
    this.dc,
    this.itunes,
    this.podcastIndex,
  });

  final String? title;
  final String? description;
  final String? link;

  final List<RssCategory> categories;
  final String? guid;
  final String? pubDate;
  final String? author;
  final String? comments;
  final RssSource? source;
  final RssContent? content;
  final Media? media;
  final RssEnclosure? enclosure;
  final DublinCore? dc;
  final RssItemItunes? itunes;
  final RssItemPodcastIndex? podcastIndex;

  RssItem copyWith({
    String? title,
    String? description,
    String? link,
    List<RssCategory>? categories,
    String? guid,
    String? pubDate,
    String? author,
    String? comments,
    RssSource? source,
    RssContent? content,
    Media? media,
    RssEnclosure? enclosure,
    DublinCore? dc,
    RssItemItunes? itunes,
    RssItemPodcastIndex? podcastIndex,
  }) {
    return RssItem(
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
      categories: categories ?? this.categories,
      guid: guid ?? this.guid,
      pubDate: pubDate ?? this.pubDate,
      author: author ?? this.author,
      comments: comments ?? this.comments,
      source: source ?? this.source,
      content: content ?? this.content,
      media: media ?? this.media,
      enclosure: enclosure ?? this.enclosure,
      dc: dc ?? this.dc,
      itunes: itunes ?? this.itunes,
      podcastIndex: podcastIndex ?? this.podcastIndex,
    );
  }

  void buildXml(XmlBuilder builder) {
    builder.element("item", nest: () {
      if (title != null) {
        builder.element("title", nest: title!);
      }

      if (link != null) {
        builder.element("link", nest: link!);
      }

      if (description != null) {
        builder.element("description", nest: description!);
      }

      if (pubDate != null) {
        builder.element("pubDate", nest: pubDate);
      }

      if (guid != null) {
        builder.element("guid", nest: guid);
      }

      if (author != null) {
        builder.element("author", nest: author);
      }

      if (enclosure != null) {
        builder.element("enclosure", attributes: {
          'url': enclosure!.url ?? '',
          'type': enclosure!.type ?? '',
          'length': enclosure!.length!.toString(),
        });
      }

    });
  }
}
