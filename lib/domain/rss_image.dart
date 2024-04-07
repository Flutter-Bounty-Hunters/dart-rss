import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssImage {
  static RssImage? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    final title = findElementOrNull(element, 'title')?.innerText;
    final url = findElementOrNull(element, 'url')?.innerText;
    final link = findElementOrNull(element, 'link')?.innerText;

    return RssImage(title, url, link);
  }

  const RssImage(this.title, this.url, this.link);

  final String? title;
  final String? link;
  final String? url;

  void buildXml(XmlBuilder builder) {
    builder.element("image", nest: () {
      if (title != null) {
        builder.element("title", nest: title!);
      }

      if (link != null) {
        builder.element("link", nest: link!);
      }

      if (url != null) {
        builder.element("url", nest: url!);
      }
    });
  }
}
