import 'package:xml/xml.dart';

class RssCategory {
  factory RssCategory.parse(XmlElement element) {
    final domain = element.getAttribute('domain');
    final value = element.innerText;
    return RssCategory(domain, value);
  }

  const RssCategory(this.domain, this.value);

  final String? domain;
  final String? value;
}
