import 'package:xml/xml.dart';

class StarRating {
  final double? average;
  final int? count;
  final int? min;
  final int? max;

  StarRating({
    this.average,
    this.count,
    this.min,
    this.max,
  });

  static StarRating? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return new StarRating(
      average: double.tryParse(element.getAttribute("average") ?? "0"),
      count: int.tryParse(element.getAttribute("count") ?? "0"),
      min: int.tryParse(element.getAttribute("min") ?? "0"),
      max: int.tryParse(element.getAttribute("max") ?? "0"),
    );
  }
}
