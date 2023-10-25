import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexGuid {
  final bool? isPermalink;
  final String? value;

  RssPodcastIndexGuid({this.isPermalink, this.value});

  static RssPodcastIndexGuid? parse(XmlElement? element) {
    if (element == null) return null;

    return RssPodcastIndexGuid(
        isPermalink: parseBool(element.getAttribute("isPermalink")),
        value: element.innerText);
  }

  @override
  String toString() {
    return 'RssPodcastIndexGuid{isPermalink: $isPermalink, value: $value}';
  }
}
