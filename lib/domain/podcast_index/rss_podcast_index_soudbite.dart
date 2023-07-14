import 'package:xml/xml.dart';

/// Points to one or more soundbites within a podcast episode.
///
/// The intended use includes episodes previews, discoverability, audiogram
/// generation, episode highlights, etc.
class RssPodcastIndexSoundbite {
  /// The time where the soundbite begins.
  final double? startTime;

  /// How long is the soundbite (recommended between 15 and 120 seconds)
  final double? duration;

  /// This is a free form string from the podcast creator to specify a title
  /// for the soundbite.
  final String? value;

  RssPodcastIndexSoundbite({
    this.startTime,
    this.duration,
    this.value,
  });

  static RssPodcastIndexSoundbite? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexSoundbite(
      startTime: double.parse(element.getAttribute('startTime') ?? '0.0'),
      duration: double.parse(element.getAttribute('duration') ?? '0.0'),
      value: element.innerText.trim(),
    );
  }
}
