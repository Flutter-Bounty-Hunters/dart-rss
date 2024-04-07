import 'package:dart_rss/domain/rss_content.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'package:dart_rss/domain/dublin_core/dublin_core.dart';

class Rss1Item {
  factory Rss1Item.parse(XmlElement element) {
    return Rss1Item(
      title: findElementOrNull(element, 'title')?.innerText,
      description: findElementOrNull(element, 'description')?.innerText,
      link: findElementOrNull(element, 'link')?.innerText,
      dc: DublinCore.parse(element),
      content: RssContent.parse(findElementOrNull(element, 'content:encoded')),
    );
  }

  const Rss1Item({
    this.title,
    this.description,
    this.link,
    this.dc,
    this.content,
  });

  final String? title;
  final String? description;
  final String? link;
  final DublinCore? dc;
  final RssContent? content;

  void buildXml(XmlBuilder builder) {
    builder.element("item", attributes: {
      "rdf:about": "http://example/org/item/",
    }, nest: () {
      if (title != null) {
        builder.element("title", nest: title);
      }

      if (description != null) {
        builder.element("description", nest: description);
      }

      if (link != null) {
        builder.element("link", nest: link);
      }

      if (content != null) {
        content!.buildXml(builder);
      }

      // TODO: dc
    });
  }
}
