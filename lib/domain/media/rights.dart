import 'package:xml/xml.dart';

class Rights {
  static Rights? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Rights(
      status: element.getAttribute('status'),
    );
  }

  const Rights({
    this.status,
  });

  final String? status;
}
