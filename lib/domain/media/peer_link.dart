import 'package:xml/xml.dart';

class PeerLink {
  final String? type;
  final String? href;
  final String? value;

  const PeerLink({
    this.type,
    this.href,
    this.value,
  });

  static PeerLink? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return PeerLink(
      type: element.getAttribute('type'),
      href: element.getAttribute('href'),
      value: element.innerText,
    );
  }
}
