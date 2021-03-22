import 'package:xml/xml.dart';

class Content {
  final String? url;
  final String? type;
  final int fileSize;
  final String? medium;
  final bool? isDefault;
  final String? expression;
  final int bitrate;
  final double framerate;
  final double samplingrate;
  final int channels;
  final int duration;
  final int height;
  final int width;
  final String? lang;

  const Content({
    this.url,
    this.type,
    this.fileSize = 0,
    this.medium,
    this.isDefault,
    this.expression,
    this.bitrate = 0,
    this.framerate = 0,
    this.samplingrate = 0,
    this.channels = 0,
    this.duration = 0,
    this.height = 0,
    this.width = 0,
    this.lang,
  });

  factory Content.parse(XmlElement element) {
    return Content(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
      fileSize: int.tryParse(element.getAttribute('fileSize') ?? '0') ?? 0,
      medium: element.getAttribute('medium'),
      isDefault: element.getAttribute('isDefault') == 'true',
      expression: element.getAttribute('expression'),
      bitrate: int.tryParse(element.getAttribute('bitrate') ?? '0') ?? 0,
      framerate: double.tryParse(element.getAttribute('framerate') ?? '0') ?? 0,
      samplingrate:
          double.tryParse(element.getAttribute('samplingrate') ?? '0') ?? 0,
      channels: int.tryParse(element.getAttribute('channels') ?? '0') ?? 0,
      duration: int.tryParse(element.getAttribute('duration') ?? '0') ?? 0,
      height: int.tryParse(element.getAttribute('height') ?? '0') ?? 0,
      width: int.tryParse(element.getAttribute('width') ?? '0') ?? 0,
      lang: element.getAttribute('lang'),
    );
  }
}
