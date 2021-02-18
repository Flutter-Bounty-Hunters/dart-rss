import 'package:xml/xml.dart';

class AtomLink {
  final String? href;
  final String? rel;
  final String? type;
  final String? hreflang;
  final String? title;
  final int length;

  const AtomLink(
    this.href,
    this.rel,
    this.type,
    this.hreflang,
    this.title,
    this.length,
  );

  factory AtomLink.parse(XmlElement element) {
    final href = element.getAttribute('href');
    final rel = element.getAttribute('rel');
    final type = element.getAttribute('type');
    final title = element.getAttribute('title');
    final hreflang = element.getAttribute('hreflang');
    var length = 0;
    final lengthElement = element.getAttribute('length');
    if (lengthElement != null) {
      length = int.tryParse(lengthElement) ?? 0;
    }
    return AtomLink(href, rel, type, hreflang, title, length);
  }
}
