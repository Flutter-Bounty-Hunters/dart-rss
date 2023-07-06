import 'package:xml/xml.dart';

class RssPodcastIndexFunding {
  final String? url;
  final String? value;

  RssPodcastIndexFunding({
    this.url,
    this.value,
  });

  static RssPodcastIndexFunding? parse(XmlElement? element) {
    if (element == null) return null;

    return RssPodcastIndexFunding(
      url: element.getAttribute('url'),
      value: element.innerText.trim(),
    );
  }
}
