import 'package:xml/xml.dart';

class Description {
  static Description? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Description(
      type: element.getAttribute('type'),
      value: element.innerText,
    );
  }

  const Description({
    this.type,
    this.value,
  });

  final String? type;
  final String? value;
}
