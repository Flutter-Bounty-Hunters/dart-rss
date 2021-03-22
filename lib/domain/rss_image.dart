import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssImage {
  final String? title;
  final String? url;
  final String? link;

  const RssImage(this.title, this.url, this.link);

  static RssImage? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final title = findElementOrNull(element, 'title')?.text;
    final url = findElementOrNull(element, 'url')?.text;
    final link = findElementOrNull(element, 'link')?.text;

    return RssImage(title, url, link);
  }
}
