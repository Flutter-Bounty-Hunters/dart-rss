import 'package:xml/xml.dart';

class Text {
  static Text? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Text(
      type: element.getAttribute('type'),
      lang: element.getAttribute('lang'),
      start: element.getAttribute('start'),
      end: element.getAttribute('end'),
      value: element.innerText,
    );
  }

  const Text({
    this.type,
    this.lang,
    this.start,
    this.end,
    this.value,
  });

  final String? type;
  final String? lang;
  final String? start;
  final String? end;
  final String? value;
}
