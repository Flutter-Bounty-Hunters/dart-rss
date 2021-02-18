import 'package:xml/xml.dart';

class Statistics {
  final int views;
  final int favorites;

  const Statistics({
    this.views = 0,
    this.favorites = 0,
  });

  static Statistics? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return Statistics(
      views: int.tryParse(element.getAttribute('views') ?? '0') ?? 0,
      favorites: int.tryParse(element.getAttribute('favorites') ?? '0') ?? 0,
    );
  }
}
