import 'package:xml/xml.dart';

class RssPodcastIndexLiveItemImages {
  static RssPodcastIndexLiveItemImages? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    final imagesElement = element.getAttribute("srcset");
    if (imagesElement == null) {
      return const RssPodcastIndexLiveItemImages(urls: null);
    }
    final urls = imagesElement.split(",").map((e) => RegExp(r"^[^s]+").firstMatch(e).toString()).toList();
    return RssPodcastIndexLiveItemImages(urls: urls);
  }

  const RssPodcastIndexLiveItemImages({required this.urls});

  final List<String>? urls;

  @override
  String toString() {
    return 'RssPodcastLiveItemImages{urls: $urls}';
  }
}
