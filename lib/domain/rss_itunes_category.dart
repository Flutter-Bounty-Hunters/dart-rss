import 'package:xml/xml.dart';

class RssItunesCategory {
  final String? category;
  final List<String?> subCategories;

  const RssItunesCategory({
    this.category,
    this.subCategories = const <String>[],
  });

  static RssItunesCategory? parse(XmlElement? element) {
    if (element == null) return null;

    Iterable<XmlElement>? subCategories;
    try {
      subCategories = element.findElements('itunes:category');
    } on StateError {
      subCategories = null;
    }
    return RssItunesCategory(
      category: element.getAttribute('text')?.trim(),
      subCategories: subCategories
              ?.map((ele) => ele.getAttribute('text')?.trim())
              .toList() ??
          <String>[],
    );
  }
}
