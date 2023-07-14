import 'package:xml/xml.dart';

/// Episodes that support the Podcasting 2.0 namespace can have a list of
/// (chapters)[https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#chapters].
///
/// This class represents a link to a chapters file. Chapters are stored separately
/// to the RSS feed.
class RssPodcastIndexChapters {
  /// The URL pointing to a chapters file.
  final String? url;

  /// The mime type of the file. Typically, this is json.
  final String? type;

  RssPodcastIndexChapters({
    this.url,
    this.type,
  });

  static RssPodcastIndexChapters? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexChapters(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
    );
  }
}
