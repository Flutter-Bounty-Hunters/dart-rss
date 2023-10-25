import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexGuid {
  static RssPodcastIndexGuid? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexGuid(
      isPermalink: parseBool(element.getAttribute("isPermalink")),
      value: element.innerText,
    );
  }

  const RssPodcastIndexGuid({
    this.isPermalink,
    this.value,
  });

  final bool? isPermalink;
  final String? value;

  @override
  String toString() {
    return 'RssPodcastIndexGuid{isPermalink: $isPermalink, value: $value}';
  }
}
