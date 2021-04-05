import 'package:dart_rss/domain/media/category.dart';
import 'package:dart_rss/domain/media/content.dart';
import 'package:dart_rss/domain/media/credit.dart';
import 'package:dart_rss/domain/media/rating.dart';
import 'package:dart_rss/domain/media/thumbnail.dart';
import 'package:dart_rss/domain/media/title.dart';
import 'package:dart_rss/domain/media/description.dart';
import 'package:dart_rss/domain/media/community.dart';
import 'package:dart_rss/util/xml.dart';
import 'package:xml/xml.dart';

class Group {
  final Title? title;
  final List<Content>? contents;
  final List<Thumbnail>? thumbnails;
  final Description? description;
  final Community? community;
  final List<Credit>? credits;
  final Category? category;
  final Rating? rating;

  Group({
    this.title,
    this.contents,
    this.thumbnails,
    this.description,
    this.community,
    this.credits,
    this.category,
    this.rating,
  });

  static parse(XmlElement? element) {
    if (element == null) return null;
    return Group(
      title: Title.parse(
        findFirstElement(element, 'media:title'),
      ),
      contents: element.findElements('media:content').map((e) {
        return Content.parse(e);
      }).toList(),
      thumbnails: element.findElements('media:thumbnail').map((e) {
        return Thumbnail.parse(e);
      }).toList(),
      description: Description.parse(
        findFirstElement(element, 'media:description'),
      ),
      community: Community.parse(
        findFirstElement(element, 'media:community'),
      ),
      credits: element.findElements('media:credit').map((e) {
        return Credit.parse(e);
      }).toList(),
      category: Category.parse(
        findFirstElement(element, 'media:category'),
      ),
      rating: Rating.parse(
        findFirstElement(element, 'media:rating'),
      ),
    );
  }
}
