import 'package:xml/xml.dart';

class Status {
  final String? state;
  final String? reason;

  const Status({
    this.state,
    this.reason,
  });

  static Status? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return Status(
      state: element.getAttribute('state'),
      reason: element.getAttribute('reason'),
    );
  }
}
