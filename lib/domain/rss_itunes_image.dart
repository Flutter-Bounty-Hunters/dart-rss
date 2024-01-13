import 'package:xml/xml.dart';

class RssItunesImage {
  static RssItunesImage? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssItunesImage(
      href: element.getAttribute('href')?.trim(),
    );
  }

  const RssItunesImage({this.href});

  final String? href;
}
