import 'package:xml/xml.dart';

class AtomCategory {
  final String? term;
  final String? scheme;
  final String? label;

  const AtomCategory(this.term, this.scheme, this.label);

  factory AtomCategory.parse(XmlElement element) {
    final term = element.getAttribute('term');
    final scheme = element.getAttribute('scheme');
    final label = element.getAttribute('label');
    return AtomCategory(term, scheme, label);
  }
}
