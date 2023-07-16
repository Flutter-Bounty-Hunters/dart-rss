import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomPerson {
  final String? name;
  final String? uri;
  final String? email;

  const AtomPerson(this.name, this.uri, this.email);

  factory AtomPerson.parse(XmlElement element) {
    final name = findElementOrNull(element, 'name')?.innerText;
    final uri = findElementOrNull(element, 'uri')?.innerText;
    final email = findElementOrNull(element, 'email')?.innerText;
    return AtomPerson(name, uri, email);
  }
}
