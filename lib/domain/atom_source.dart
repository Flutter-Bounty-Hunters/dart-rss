import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomSource {
  final String? id;
  final String? title;
  final String? updated;

  const AtomSource(this.id, this.title, this.updated);

  static AtomSource? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final id = findElementOrNull(element, 'id')?.value;
    final title = findElementOrNull(element, 'title')?.value;
    final updated = findElementOrNull(element, 'updated')?.value;
    return AtomSource(id, title, updated);
  }
}
