import 'package:xml/xml.dart';

class RssEnclosure {
  static RssEnclosure? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    final url = element.getAttribute('url');
    final type = element.getAttribute('type');
    final length = int.tryParse(element.getAttribute('length') ?? '0') ?? 0;
    return RssEnclosure(url, type, length);
  }

  const RssEnclosure(this.url, this.type, this.length);

  final String? url;
  final String? type;
  final int length;
}
