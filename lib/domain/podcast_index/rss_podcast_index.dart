import 'package:dart_rss/domain/podcast_index/rss_podcast_index_funding.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_locked.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_person.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

/// This is the root class for the (Podcasting 2.0 namespace)[https://github.com/Podcastindex-org/podcast-namespace/blob/main/podcasting2.0.md].
class RssPodcastIndex {
  /// List of funding tags.
  final List<RssPodcastIndexFunding?>? funding;

  /// List of persons associated with the podcast.
  final List<RssPodcastIndexPerson?>? persons;

  /// The purpose is to tell other podcast hosting platforms whether they are allowed to import this feed.
  final RssPodcastIndexLocked? locked;

  RssPodcastIndex({
    this.funding,
    this.persons,
    this.locked,
  });

  static RssPodcastIndex? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndex(
      funding: element.findElements('podcast:funding').map((e) {
        return RssPodcastIndexFunding.parse(e);
      }).toList(),
      persons: element.findElements('podcast:person').map((e) {
        return RssPodcastIndexPerson.parse(e);
      }).toList(),
      locked: RssPodcastIndexLocked.parse(
        findElementOrNull(element, 'podcast:locked'),
      ),
    );
  }
}
