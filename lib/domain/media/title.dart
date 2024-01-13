import 'package:xml/xml.dart';

class Title {
  static Title? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Title(
      type: element.getAttribute('type'),
      value: element.innerText,
    );
  }

  const Title({
    this.type,
    this.value,
  });

  final String? type;
  final String? value;
}
