import 'package:xml/xml.dart';

class Credit {
  factory Credit.parse(XmlElement element) {
    return Credit(
      role: element.getAttribute('role'),
      scheme: element.getAttribute('scheme'),
      value: element.innerText,
    );
  }

  const Credit({
    this.role,
    this.scheme,
    this.value,
  });

  final String? role;
  final String? scheme;
  final String? value;
}
