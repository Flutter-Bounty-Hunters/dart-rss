import 'package:xml/xml.dart';

class Thumbnail {
  factory Thumbnail.parse(XmlElement element) {
    return Thumbnail(
      url: element.getAttribute('url'),
      width: element.getAttribute('width'),
      height: element.getAttribute('height'),
      time: element.getAttribute('time'),
    );
  }

  const Thumbnail({
    this.url,
    this.width,
    this.height,
    this.time,
  });

  final String? url;
  final String? width;
  final String? height;
  final String? time;
}
