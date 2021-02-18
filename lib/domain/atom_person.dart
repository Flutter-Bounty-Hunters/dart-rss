import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomPerson {
  final String? name;
  final String? uri;
  final String? email;

  const AtomPerson(this.name, this.uri, this.email);

  factory AtomPerson.parse(XmlElement element) {
    final name = findElementOrNull(element, 'name')?.text;
    final uri = findElementOrNull(element, 'uri')?.text;
    final email = findElementOrNull(element, 'email')?.text;
    return AtomPerson(name, uri, email);
  }
}
