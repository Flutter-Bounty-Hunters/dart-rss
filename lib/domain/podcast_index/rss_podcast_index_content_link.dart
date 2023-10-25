import 'package:xml/xml.dart';

class RssPodcastIndexContentLink {
  final String? href;
  final String? value;

  RssPodcastIndexContentLink({this.href, this.value});

  static RssPodcastIndexContentLink parse(XmlElement element) {
    return RssPodcastIndexContentLink(
      value: element.innerText,
      href: element.getAttribute("href"),
    );
  }

  @override
  String toString() {
    return 'RssPodcastIndexContentLink{href: $href, value: $value}';
  }
}
