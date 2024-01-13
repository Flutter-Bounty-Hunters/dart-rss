import 'package:xml/xml.dart';

enum RssItunesType {
  episodic,
  serial;

  static RssItunesType? parse(XmlElement? element) {
    // "episodic" is default type
    if (element == null) {
      return RssItunesType.episodic;
    }

    switch (element.innerText) {
      case 'episodic':
        return RssItunesType.episodic;
      case 'serial':
        return RssItunesType.serial;
      default:
        return null;
    }
  }
}
