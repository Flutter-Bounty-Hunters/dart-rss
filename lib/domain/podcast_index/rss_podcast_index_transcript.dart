import 'package:xml/xml.dart';

class RssPodcastIndexTranscript {
  final String? url;
  final String? type;
  final String? language;
  final String? rel;

  RssPodcastIndexTranscript({
    this.url,
    this.type,
    this.language,
    this.rel,
  });

  static RssPodcastIndexTranscript? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexTranscript(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
      language: element.getAttribute('language'),
      rel: element.getAttribute('rel'),
    );
  }
}
