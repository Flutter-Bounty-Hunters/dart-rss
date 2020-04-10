import 'package:dart_rss/domain/media/category.dart';
import 'package:dart_rss/domain/media/content.dart';
import 'package:dart_rss/domain/media/credit.dart';
import 'package:dart_rss/domain/media/rating.dart';
import 'package:dart_rss/domain/media/thumbnail.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Group {
  final List<Content> contents;
  final List<Credit> credits;
  final List<Thumbnail> thumbnails;
  final Category category;
  final Rating rating;

  Group(
      {this.contents,
      this.credits,
      this.thumbnails,
      this.category,
      this.rating});

  factory Group.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    return new Group(
      contents: element.findElements("media:content").map((e) {
        return new Content.parse(e);
      }).toList(),
      credits: element.findElements("media:credit").map((e) {
        return new Credit.parse(e);
      }).toList(),
      thumbnails: element.findElements("media:thumbnail").map((e) {
        return new Thumbnail.parse(e);
      }).toList(),
      category: new Category.parse(
        findElementOrNull(element, "media:category"),
      ),
      rating: new Rating.parse(
        findElementOrNull(element, "media:rating"),
      ),
    );
  }
}
