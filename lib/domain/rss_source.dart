import 'package:xml/xml.dart';

class RssSource {
  final String? url;
  final String value;

  const RssSource(this.url, this.value);

  static RssSource? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final url = element.getAttribute('url');
    final value = element.innerText;

    return RssSource(url, value);
  }
}
