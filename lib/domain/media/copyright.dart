import 'package:xml/xml.dart';

class Copyright {
  static Copyright? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Copyright(
      url: element.getAttribute('url'),
      value: element.innerText,
    );
  }

  const Copyright({
    this.url,
    this.value,
  });

  final String? url;
  final String? value;
}
