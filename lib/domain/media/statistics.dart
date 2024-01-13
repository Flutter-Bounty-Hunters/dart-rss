import 'package:xml/xml.dart';

class Statistics {
  static Statistics? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Statistics(
      views: int.tryParse(element.getAttribute('views') ?? '0') ?? 0,
      favorites: int.tryParse(element.getAttribute('favorites') ?? '0') ?? 0,
    );
  }

  const Statistics({
    this.views = 0,
    this.favorites = 0,
  });

  final int views;
  final int favorites;
}
