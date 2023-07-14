import 'package:xml/xml.dart';

/// This class represents a funding link which consists of a URL and displayable
/// value.
///
/// Funding tags allow podcasters to point end users to a page where they can
/// support their show.
class RssPodcastIndexFunding {
  /// The URL of the page where a user can support the show.
  final String? url;

  /// The value to display.
  final String? value;

  RssPodcastIndexFunding({
    this.url,
    this.value,
  });

  static RssPodcastIndexFunding? parse(XmlElement? element) {
    if (element == null) return null;

    return RssPodcastIndexFunding(
      url: element.getAttribute('url'),
      value: element.innerText.trim(),
    );
  }
}
