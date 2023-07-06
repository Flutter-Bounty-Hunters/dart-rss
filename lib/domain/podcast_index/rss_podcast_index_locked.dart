import 'package:xml/xml.dart';

class RssPodcastIndexLocked {
  /// The owner attribute is an email address that can be used to verify
  /// ownership of this feed during move and import operations.
  final String? owner;

  /// Are we locked?
  final bool? locked;

  RssPodcastIndexLocked({
    this.owner,
    this.locked,
  });

  static RssPodcastIndexLocked? parse(XmlElement? element) {
    if (element == null) return null;

    return RssPodcastIndexLocked(
      owner: element.getAttribute('owner'),
      locked: element.innerText == 'yes' ? true : false,
    );
  }
}
