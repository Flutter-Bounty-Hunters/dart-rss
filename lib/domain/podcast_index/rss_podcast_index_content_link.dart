import 'package:xml/xml.dart';

class RssPodcastIndexContentLink {
  static RssPodcastIndexContentLink parse(XmlElement element) {
    return RssPodcastIndexContentLink(
      value: element.innerText,
      href: element.getAttribute("href"),
    );
  }

  const RssPodcastIndexContentLink({
    this.href,
    this.value,
  });

  final String? href;
  final String? value;

  @override
  String toString() {
    return 'RssPodcastIndexContentLink{href: $href, value: $value}';
  }
}
