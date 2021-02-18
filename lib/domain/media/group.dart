import 'package:dart_rss/domain/media/category.dart';
import 'package:dart_rss/domain/media/content.dart';
import 'package:dart_rss/domain/media/credit.dart';
import 'package:dart_rss/domain/media/rating.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Group {
  final List<Content> contents;
  final List<Credit> credits;
  final Category? category;
  final Rating? rating;

  const Group({
    this.contents = const <Content>[],
    this.credits = const <Credit>[],
    this.category,
    this.rating,
  });

  static Group? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return Group(
      contents: element
          .findElements('media:content')
          .map((e) => Content.parse(e))
          .toList(),
      credits: element
          .findElements('media:credit')
          .map((e) => Credit.parse(e))
          .toList(),
      category: Category.parse(findElementOrNull(element, 'media:category')),
      rating: Rating.parse(findElementOrNull(element, 'media:rating')),
    );
  }
}
