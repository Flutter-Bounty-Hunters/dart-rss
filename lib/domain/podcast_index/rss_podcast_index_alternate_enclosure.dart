import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexAlternateEnclosure {
  final String? type;
  final int? length;
  final bool? isDefault;

  RssPodcastIndexAlternateEnclosure(
      {required this.type, required this.length, required this.isDefault});

  static RssPodcastIndexAlternateEnclosure? parse(XmlElement? element) {
    if (element == null) return null;
    return RssPodcastIndexAlternateEnclosure(
      type: element.getAttribute("type"),
      length: parseInt(element.getAttribute("length")),
      isDefault: parseBool(element.getAttribute("default")),
    );
  }

  @override
  String toString() {
    return 'RssPodcastIndexAlternateEnclosure{type: $type, length: $length, isDefault: $isDefault}';
  }
}
