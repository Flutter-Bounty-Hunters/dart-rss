import 'package:dart_rss/domain/podcast_index/rss_podcast_index_chapters.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_person.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_soudbite.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_transcript.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

/// This is the root class for the (Podcasting 2.0 namespace)[https://github.com/Podcastindex-org/podcast-namespace/blob/main/podcasting2.0.md].
/// at the [RssItem] level.
class RssItemPodcastIndex {
  /// An optional list of chapters for the episode.
  final RssPodcastIndexChapters? chapters;

  /// An optional list of URLs that each point to a transcript file.
  final List<RssPodcastIndexTranscript?> transcripts;

  /// An optional list of sound bites.
  final List<RssPodcastIndexSoundbite?> soundbites;

  /// An option list of persons for the episode.
  final List<RssPodcastIndexPerson?> persons;

  RssItemPodcastIndex({
    this.chapters,
    this.transcripts = const <RssPodcastIndexTranscript>[],
    this.soundbites = const <RssPodcastIndexSoundbite>[],
    this.persons = const <RssPodcastIndexPerson>[],
  });

  factory RssItemPodcastIndex.parse(XmlElement element) {
    return RssItemPodcastIndex(
      chapters: RssPodcastIndexChapters.parse(
        findElementOrNull(element, 'podcast:chapters'),
      ),
      transcripts: element.findElements('podcast:transcript').map((e) {
        return RssPodcastIndexTranscript.parse(e);
      }).toList(),
      soundbites: element.findElements('podcast:soundbite').map((e) {
        return RssPodcastIndexSoundbite.parse(e);
      }).toList(),
      persons: element.findElements('podcast:person').map((e) {
        return RssPodcastIndexPerson.parse(e);
      }).toList(),
    );
  }
}
