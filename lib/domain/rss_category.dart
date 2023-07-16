import 'package:xml/xml.dart';

class RssCategory {
  final String? domain;
  final String? value;

  const RssCategory(this.domain, this.value);

  factory RssCategory.parse(XmlElement element) {
    final domain = element.getAttribute('domain');
    final value = element.innerText;
    return RssCategory(domain, value);
  }
}
