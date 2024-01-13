import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Scene {
  factory Scene.parse(XmlElement element) {
    return Scene(
      title: findElementOrNull(element, 'sceneTitle')?.innerText,
      description: findElementOrNull(element, 'sceneDescription')?.innerText,
      startTime: findElementOrNull(element, 'sceneStartTime')?.innerText,
      endTime: findElementOrNull(element, 'sceneEndTime')?.innerText,
    );
  }

  const Scene({
    this.title,
    this.description,
    this.startTime,
    this.endTime,
  });

  final String? title;
  final String? description;
  final String? startTime;
  final String? endTime;
}
