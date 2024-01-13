import 'package:xml/xml.dart';

class License {
  static License? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return License(
      type: element.getAttribute('type'),
      href: element.getAttribute('href'),
      value: element.innerText,
    );
  }

  const License({
    this.type,
    this.href,
    this.value,
  });

  final String? type;
  final String? href;
  final String? value;
}
