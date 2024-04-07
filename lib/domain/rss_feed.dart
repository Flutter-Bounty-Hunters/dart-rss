import 'dart:core';

import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index.dart';
import 'package:dart_rss/domain/rss_category.dart';
import 'package:dart_rss/domain/rss_cloud.dart';
import 'package:dart_rss/domain/rss_image.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'package:dart_rss/domain/rss_itunes.dart';

class RssFeed {
  factory RssFeed.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements('channel').first;
    } on StateError {
      throw ArgumentError('channel not found');
    }

    return RssFeed(
      title: findElementOrNull(channelElement, 'title')?.innerText,
      author: findElementOrNull(channelElement, 'author')?.innerText,
      description: findElementOrNull(channelElement, 'description')?.innerText,
      link: findElementOrNull(channelElement, 'link')?.innerText,
      items: channelElement.findElements('item').map((element) => RssItem.parse(element)).toList(),
      image: RssImage.parse(findElementOrNull(channelElement, 'image')),
      cloud: RssCloud.parse(findElementOrNull(channelElement, 'cloud')),
      categories: channelElement.findElements('category').map((element) => RssCategory.parse(element)).toList(),
      skipDays: findElementOrNull(channelElement, 'skipDays')
              ?.findAllElements('day')
              .map((element) => element.innerText)
              .toList() ??
          <String>[],
      skipHours: findElementOrNull(channelElement, 'skipHours')
              ?.findAllElements('hour')
              .map((element) => int.tryParse(element.innerText) ?? 0)
              .toList() ??
          <int>[],
      lastBuildDate: findElementOrNull(channelElement, 'lastBuildDate')?.innerText,
      language: findElementOrNull(channelElement, 'language')?.innerText,
      generator: findElementOrNull(channelElement, 'generator')?.innerText,
      copyright: findElementOrNull(channelElement, 'copyright')?.innerText,
      docs: findElementOrNull(channelElement, 'docs')?.innerText,
      managingEditor: findElementOrNull(channelElement, 'managingEditor')?.innerText,
      rating: findElementOrNull(channelElement, 'rating')?.innerText,
      webMaster: findElementOrNull(channelElement, 'webMaster')?.innerText,
      ttl: int.tryParse(
            findElementOrNull(channelElement, 'ttl')?.innerText ?? '0',
          ) ??
          0,
      dc: DublinCore.parse(channelElement),
      itunes: RssItunes.parse(channelElement),
      podcastIndex: RssPodcastIndex.parse(channelElement),
    );
  }

  const RssFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items = const <RssItem>[],
    this.image,
    this.cloud,
    this.categories = const <RssCategory>[],
    this.skipDays = const <String>[],
    this.skipHours = const <int>[],
    this.pubDate,
    this.lastBuildDate,
    this.language,
    this.generator,
    this.copyright,
    this.docs,
    this.managingEditor,
    this.rating,
    this.webMaster,
    this.ttl = 0,
    this.dc,
    this.itunes,
    this.podcastIndex,
  });

  final String? title;
  final String? author;
  final String? description;
  final String? link;
  final RssImage? image;
  final RssCloud? cloud;
  final List<RssCategory> categories;
  final List<String> skipDays;
  final List<int> skipHours;

  /// The most recent date when any content within the channel changed.
  ///
  /// A content change might refer to the addition of an `item`, or
  /// it might refer to a change to the channel title, description, etc.
  ///
  /// In typical cases, [pubDate] matches [lastBuildDate] because a
  /// recreation of the RSS feed typically happens for the purpose of
  /// updating content. However, there may be cases where the feed is
  /// recreated without a content change, in which case [pubDate] will
  /// be behind [lastBuildDate].
  final String? pubDate;

  /// The most recent date when the RSS feed was recreated/regenerated.
  ///
  /// Typically, an RSS feed is recreated for the purpose of adding or
  /// altering content, in which case [lastBuildDate] should match
  /// [pubDate]. However, it's possible that the value is recreated
  /// for some other purpose, in which case [pubDate] will be behind
  /// [lastBuildDate].
  ///
  /// Think of the RSS feed file as cached data, and think of [lastBuildDate]
  /// as the date in which the cache was most recently updated.
  final String? lastBuildDate;
  final String? language;
  final String? generator;
  final String? copyright;
  final String? docs;
  final String? managingEditor;
  final String? rating;
  final String? webMaster;
  final int ttl;

  final List<RssItem> items;

  final DublinCore? dc;
  final RssItunes? itunes;

  // TODO: Rework the model for RssPodcastIndex. This looks like an artificial construct that was
  //       introduced to hold podcast extensions, even though some/all of those extensions are
  //       supposed to be able to apply directly to a channel.
  final RssPodcastIndex? podcastIndex;

  XmlDocument toXmlDocument() {
    final builder = XmlBuilder();
    builder.element("rss", attributes: {
      "version": "2.0",
    }, nest: () {
      builder.element("channel", nest: () {
        if (title != null) {
          builder.element("title", nest: title!);
        }

        if (description != null) {
          builder.element("description", nest: description!);
        }

        if (link != null) {
          builder.element("link", nest: link!);
        }

        if (language != null) {
          builder.element("language", nest: language!);
        }

        if (pubDate != null) {
          builder.element("pubDate", nest: pubDate!);
        }

        if (lastBuildDate != null) {
          builder.element("lastBuildDate", nest: lastBuildDate!);
        }

        if (docs != null) {
          builder.element("docs", nest: docs);
        }

        for (final item in items) {
          item.buildXml(builder);
        }
      });

      // TODO: add all remaining properties.
    });

    return builder.buildDocument();
  }
}
