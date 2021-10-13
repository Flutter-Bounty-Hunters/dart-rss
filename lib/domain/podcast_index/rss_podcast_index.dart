import 'package:dart_rss/domain/podcast_index/rss_podcast_index_funding.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_locked.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_value.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndex {
  final List<RssPodcastIndexFunding?>? funding;
  final RssPodcastIndexLocked? locked;
  final RssPodcastIndexValue? value;


  RssPodcastIndex({
    this.funding,
    this.locked,
    this.value,
  });

  static RssPodcastIndex? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndex(
      funding: element.findElements('podcast:funding').map((e) {
        return RssPodcastIndexFunding.parse(e);
      }).toList(),
      locked: RssPodcastIndexLocked.parse(findElementOrNull(element, 'podcast:locked')),
      value: RssPodcastIndexValue.parse(findDirectElementOrNull(element, 'podcast:value')),
    );
  }
}
