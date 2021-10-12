import 'package:xml/xml.dart';

class RssPodcastIndexValue {
  final String? type;
  final String? method;
  final String? suggested;
  final List<RssPodcastIndexValueRecipient?> recipients;

  RssPodcastIndexValue({
    this.type,
    this.method,
    this.suggested,
    this.recipients = const <RssPodcastIndexValueRecipient>[],
  });

  static RssPodcastIndexValue? parse(XmlElement? element) {
    if (element == null) return null;

    return RssPodcastIndexValue(
      type: element.getAttribute('type'),
      method: element.getAttribute('method'),
      suggested: element.getAttribute('suggested'),
      recipients: element
          .findElements('podcast:valueRecipient')
          .map((element) => RssPodcastIndexValueRecipient.parse(element))
          .toList(),
    );
  }
}

class RssPodcastIndexValueRecipient {
  final String? name;
  final String? type;
  final String? address;
  final String? customKey;
  final String? customValue;
  final String? split;
  final String? fee;

  RssPodcastIndexValueRecipient({
    this.name,
    this.type,
    this.address,
    this.customKey,
    this.customValue,
    this.split,
    this.fee,
  });

  static RssPodcastIndexValueRecipient? parse(XmlElement? element) {
    if (element == null) return null;

    return RssPodcastIndexValueRecipient(
      name: element.getAttribute('name'),
      type: element.getAttribute('type'),
      address: element.getAttribute('address'),
      customKey: element.getAttribute('customKey'),
      customValue: element.getAttribute('customValue'),
      split: element.getAttribute('split'),
      fee: element.getAttribute('fee'),
    );
  }
}

