import 'package:xml/xml.dart';

final _imagesRegExp = RegExp(
  "<img\\s.*?src=(?:'|\")([^'\">]+)(?:'|\")",
  multiLine: true,
  caseSensitive: false,
);

/// For RSS Content Module:
///
/// - `xmlns:content="http://purl.org/rss/1.0/modules/content/"`
///
class RssContent {
  final String value;
  final Iterable<String> images;

  const RssContent(this.value, this.images);

  static RssContent? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final content = element.innerText;
    final images = <String>[];
    _imagesRegExp.allMatches(content).forEach((match) {
      final matchGroup = match.group(1);
      if (matchGroup != null) images.add(matchGroup);
    });
    return RssContent(content, images);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RssContent &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          images == other.images;

  @override
  int get hashCode => value.hashCode ^ images.hashCode;
}
