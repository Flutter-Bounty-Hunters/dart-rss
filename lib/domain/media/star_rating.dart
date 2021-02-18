import 'package:xml/xml.dart';

class StarRating {
  final double average;
  final int count;
  final int min;
  final int max;

  const StarRating({
    this.average = 0,
    this.count = 0,
    this.min = 0,
    this.max = 0,
  });

  static StarRating? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return StarRating(
      average: double.tryParse(element.getAttribute('average') ?? '0') ?? 0,
      count: int.tryParse(element.getAttribute('count') ?? '0') ?? 0,
      min: int.tryParse(element.getAttribute('min') ?? '0') ?? 0,
      max: int.tryParse(element.getAttribute('max') ?? '0') ?? 0,
    );
  }
}
