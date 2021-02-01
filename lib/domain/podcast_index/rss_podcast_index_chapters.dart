import 'package:xml/xml.dart';

class RssPodcastIndexChapters {
  final String url;
  final String type;

  RssPodcastIndexChapters({
    this.url,
    this.type,
  });

  factory RssPodcastIndexChapters.parse(XmlElement element) {
    if (element == null) {
      return null;
    }

    return new RssPodcastIndexChapters(
      url: element.getAttribute("url"),
      type: element.getAttribute("type"),
    );
  }
}
