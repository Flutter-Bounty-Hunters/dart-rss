import 'package:xml/xml.dart';

class Param {
  factory Param.parse(XmlElement element) {
    return Param(
      name: element.getAttribute('name'),
      value: element.innerText,
    );
  }

  const Param({
    this.name,
    this.value,
  });

  final String? name;
  final String? value;
}
