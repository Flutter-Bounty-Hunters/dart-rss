import 'package:xml/xml.dart';

class Description {
  final String? type;
  final String? value;

  const Description({
    this.type,
    this.value,
  });

  static Description? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return Description(
      type: element.getAttribute('type'),
      value: element.innerText,
    );
  }
}
