import 'package:xml/xml.dart';

class RssItunesImage {
  final String? href;

  const RssItunesImage({this.href});

  static RssItunesImage? parse(XmlElement? element) {
    if (element == null) return null;
    return RssItunesImage(
      href: element.getAttribute('href')?.trim(),
    );
  }
}
