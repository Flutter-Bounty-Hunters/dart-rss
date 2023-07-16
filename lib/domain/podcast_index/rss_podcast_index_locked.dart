import 'package:xml/xml.dart';

/// The purpose is to tell other podcast hosting platforms whether they are
/// allowed to import this feed.
///
/// A value of yes means that any attempt to import this feed into a new
/// platform should be rejected.
///
/// This tag may be set to yes or no.
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
