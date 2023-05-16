import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Scene {
  final String? title;
  final String? description;
  final String? startTime;
  final String? endTime;

  const Scene({
    this.title,
    this.description,
    this.startTime,
    this.endTime,
  });

  factory Scene.parse(XmlElement element) {
    return Scene(
      title: findElementOrNull(element, 'sceneTitle')?.value,
      description: findElementOrNull(element, 'sceneDescription')?.value,
      startTime: findElementOrNull(element, 'sceneStartTime')?.value,
      endTime: findElementOrNull(element, 'sceneEndTime')?.value,
    );
  }
}
