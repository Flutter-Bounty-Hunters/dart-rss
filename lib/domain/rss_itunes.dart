import 'package:xml/xml.dart';

import 'package:dart_rss/util/helpers.dart';

import 'rss_itunes_category.dart';
import 'rss_itunes_image.dart';
import 'rss_itunes_owner.dart';
import 'rss_itunes_type.dart';

class RssItunes {
  final String? author;
  final String? summary;
  final bool? explicit;
  final String? title;
  final String? subtitle;
  final RssItunesOwner? owner;
  final List<String> keywords;
  final RssItunesImage? image;
  final List<RssItunesCategory?> categories;
  final RssItunesType? type;
  final String? newFeedUrl;
  final bool? block;
  final bool? complete;

  const RssItunes({
    this.author,
    this.summary,
    this.explicit,
    this.title,
    this.subtitle,
    this.owner,
    this.keywords = const <String>[],
    this.image,
    this.categories = const <RssItunesCategory?>[],
    this.type,
    this.newFeedUrl,
    this.block,
    this.complete,
  });

  factory RssItunes.parse(XmlElement element) {
    final categories = findAllDirectElementsOrNull(element, 'itunes:category');
    return RssItunes(
      author: findElementOrNull(element, 'itunes:author')?.innerText.trim(),
      summary: findElementOrNull(element, 'itunes:summary')?.innerText.trim(),
      explicit: parseBoolLiteral(element, 'itunes:explicit'),
      title: findElementOrNull(element, 'itunes:title')?.innerText.trim(),
      subtitle: findElementOrNull(element, 'itunes:subtitle')?.innerText.trim(),
      owner: RssItunesOwner.parse(findElementOrNull(element, 'itunes:owner')),
      keywords: findElementOrNull(element, 'itunes:keywords')
              ?.innerText
              .split(',')
              .map((keyword) => keyword.trim())
              .toList() ??
          const <String>[],
      image: RssItunesImage.parse(findElementOrNull(element, 'itunes:image')),
      categories:
          categories?.map((ele) => RssItunesCategory.parse(ele)).toList() ??
              const <RssItunesCategory>[],
      type: newRssItunesType(findElementOrNull(element, 'itunes:type')),
      newFeedUrl:
          findElementOrNull(element, 'itunes:new-feed-url')?.innerText.trim(),
      block: parseBoolLiteral(element, 'itunes:block'),
      complete: parseBoolLiteral(element, 'itunes:complete'),
    );
  }
}
