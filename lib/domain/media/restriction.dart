import 'package:xml/xml.dart';

class Restriction {
  static Restriction? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Restriction(
      relationship: element.getAttribute('relationship'),
      type: element.getAttribute('type'),
      value: element.innerText,
    );
  }

  const Restriction({
    this.relationship,
    this.type,
    this.value,
  });

  final String? relationship;
  final String? type;
  final String? value;
}
