import 'package:xml/xml.dart';

class RssSource {
  final String? url;
  final String value;

  const RssSource(this.url, this.value);

  static RssSource? parse(XmlElement? element) {
    if (element == null || element.value == null) {
      return null;
    }
    final url = element.getAttribute('url');
    final value = element.value;

    return RssSource(url, value!);
  }
}
