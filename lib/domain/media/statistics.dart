import 'package:xml/xml.dart';

class Statistics {
  final int? views;
  final int? favorites;

  Statistics({
    this.views,
    this.favorites,
  });

  static Statistics? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return new Statistics(
      views: int.tryParse(element.getAttribute("views") ?? "0"),
      favorites: int.tryParse(element.getAttribute("favorites") ?? "0"),
    );
  }
}
