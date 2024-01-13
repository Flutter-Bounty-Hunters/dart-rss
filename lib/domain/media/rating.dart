import 'package:xml/xml.dart';

class Rating {
  static Rating? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Rating(
      scheme: element.getAttribute('scheme'),
      value: element.innerText,
    );
  }

  const Rating({
    this.scheme,
    this.value,
  });

  final String? scheme;
  final String? value;
}
