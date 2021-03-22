import 'package:xml/xml.dart';

class RssPodcastIndexChapters {
  final String? url;
  final String? type;

  RssPodcastIndexChapters({
    this.url,
    this.type,
  });

  static RssPodcastIndexChapters? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexChapters(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
    );
  }
}
