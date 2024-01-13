import 'package:xml/xml.dart';

class AtomGenerator {
  static AtomGenerator? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    final uri = element.getAttribute('uri');
    final version = element.getAttribute('version');
    final value = element.innerText;
    return AtomGenerator(uri, version, value);
  }

  const AtomGenerator(this.uri, this.version, this.value);

  final String? uri;
  final String? version;
  final String? value;
}
