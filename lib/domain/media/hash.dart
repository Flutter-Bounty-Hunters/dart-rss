import 'package:xml/xml.dart';

class Hash {
  static Hash? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Hash(
      algo: element.getAttribute('algo'),
      value: element.innerText,
    );
  }

  const Hash({
    this.algo,
    this.value,
  });

  final String? algo;
  final String? value;
}
