import 'package:xml/xml.dart';

class RssPodcastIndexSoundbite {
  final double? startTime;
  final double? duration;
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
