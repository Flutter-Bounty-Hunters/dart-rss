import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexLiveItemImages {
  final List<String>? urls;

  RssPodcastIndexLiveItemImages({required this.urls});

  static RssPodcastIndexLiveItemImages? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    final imagesElement = element.getAttribute("srcset");
    if (imagesElement == null) return RssPodcastIndexLiveItemImages(urls: null);
    final urls = imagesElement
        .split(",")
        .map((e) => RegExp(r"^[s]+").firstMatch(e).toString())
        .toList();
    return RssPodcastIndexLiveItemImages(urls: urls);
  }

  @override
  String toString() {
    return 'RssPodcastLiveItemImages{urls: $urls}';
  }
}
