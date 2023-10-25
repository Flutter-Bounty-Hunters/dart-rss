import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexAlternateEnclosure {
  static RssPodcastIndexAlternateEnclosure? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexAlternateEnclosure(
      type: element.getAttribute("type"),
      length: parseInt(element.getAttribute("length")),
      isDefault: parseBool(element.getAttribute("default")),
    );
  }

  const RssPodcastIndexAlternateEnclosure({
    required this.type,
    required this.length,
    required this.isDefault,
  });

  final String? type;
  final int? length;
  final bool? isDefault;

  @override
  String toString() {
    return 'RssPodcastIndexAlternateEnclosure{type: $type, length: $length, isDefault: $isDefault}';
  }
}
