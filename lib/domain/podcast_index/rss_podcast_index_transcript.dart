import 'package:xml/xml.dart';

/// This class represents a link to a transcript or closed captions file.
///
/// Multiple tags can be present for multiple transcript formats.
class RssPodcastIndexTranscript {
  /// URL of the podcast transcript.
  final String? url;

  /// Mime type of the file such as text/plain, text/html, text/vtt,
  /// application/json, application/x-subrip
  final String? type;

  /// The language of the linked transcript. If there is no language attribute
  /// given, the linked file is assumed to be the same language that is
  /// specified by the RSS `<language>` element.
  final String? language;

  ///  If the rel="captions" attribute is present, the linked file is considered
  ///  to be a closed captions file, regardless of what the mime type is.
  final String? rel;

  RssPodcastIndexTranscript({
    this.url,
    this.type,
    this.language,
    this.rel,
  });

  static RssPodcastIndexTranscript? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexTranscript(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
      language: element.getAttribute('language'),
      rel: element.getAttribute('rel'),
    );
  }
}
