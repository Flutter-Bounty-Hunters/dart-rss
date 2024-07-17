import 'package:dart_rss/domain/media/category.dart';
import 'package:dart_rss/domain/media/content.dart';
import 'package:dart_rss/domain/media/credit.dart';
import 'package:dart_rss/domain/media/rating.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'thumbnail.dart';

class Group {
  static Group? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Group(
      contents: element.findElements('media:content').map((e) => Content.parse(e)).toList(),
      credits: element.findElements('media:credit').map((e) => Credit.parse(e)).toList(),
      thumbnails: element.findElements('media:thumbnail').map((e) => Thumbnail.parse(e)).toList(),
      category: Category.parse(findElementOrNull(element, 'media:category')),
      rating: Rating.parse(findElementOrNull(element, 'media:rating')),
    );
  }

  const Group({
    this.contents = const <Content>[],
    this.credits = const <Credit>[],
    this.thumbnails = const <Thumbnail>[],
    this.category,
    this.rating,
  });

  final List<Content> contents;
  final List<Credit> credits;
  final List<Thumbnail> thumbnails;
  final Category? category;
  final Rating? rating;
}
