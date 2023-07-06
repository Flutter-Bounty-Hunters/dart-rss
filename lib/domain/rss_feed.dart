import 'dart:core';

import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index.dart';
import 'package:dart_rss/domain/rss_category.dart';
import 'package:dart_rss/domain/rss_cloud.dart';
import 'package:dart_rss/domain/rss_image.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'rss_itunes.dart';

class RssFeed {
  final String? title;
  final String? author;
  final String? description;
  final String? link;
  final List<RssItem> items;

  final RssImage? image;
  final RssCloud? cloud;
  final List<RssCategory> categories;
  final List<String> skipDays;
  final List<int> skipHours;
  final String? lastBuildDate;
  final String? language;
  final String? generator;
  final String? copyright;
  final String? docs;
  final String? managingEditor;
  final String? rating;
  final String? webMaster;
  final int ttl;
  final DublinCore? dc;
  final RssItunes? itunes;
  final RssPodcastIndex? podcastIndex;

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
      ttl: int.tryParse(findElementOrNull(channelElement, 'ttl')?.innerText ?? '0',) ?? 0,
      dc: DublinCore.parse(channelElement),
      itunes: RssItunes.parse(channelElement),
      podcastIndex: RssPodcastIndex.parse(channelElement),
    );
  }
}
