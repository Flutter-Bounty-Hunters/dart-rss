import 'package:xml/xml.dart';

class Param {
  final String? name;
  final String? value;

  const Param({
    this.name,
    this.value,
  });

  factory Param.parse(XmlElement element) {
    return Param(
      name: element.getAttribute('name'),
      value: element.innerText,
    );
  }
}
