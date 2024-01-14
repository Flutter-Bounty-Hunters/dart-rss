import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

// TODO: Complete the definition for the "alternativeEnclosure" tag (
/// The `alternativeEnclosure` XML element.
///
/// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#alternate-enclosure
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
