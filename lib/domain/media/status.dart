import 'package:xml/xml.dart';

class Status {
  static Status? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Status(
      state: element.getAttribute('state'),
      reason: element.getAttribute('reason'),
    );
  }

  const Status({
    this.state,
    this.reason,
  });

  final String? state;
  final String? reason;
}
