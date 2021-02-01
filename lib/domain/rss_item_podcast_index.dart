import 'package:dart_rss/domain/podcast_index/rss_podcast_index_chapters.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_soudbite.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_transcript.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssItemPodcastIndex {
  final RssPodcastIndexChapters chapters;
  final List<RssPodcastIndexTranscript> transcripts;
  final List<RssPodcastIndexSoundbite> soundbites;

  RssItemPodcastIndex({
    this.chapters,
    this.transcripts,
    this.soundbites,
  });

  factory RssItemPodcastIndex.parse(XmlElement element) {
    if (element == null) {
      return null;
    }

    return RssItemPodcastIndex(
      chapters: RssPodcastIndexChapters.parse(findElementOrNull(element, "podcast:chapters")),
      transcripts: element.findElements("podcast:transcript").map((e) {
        return new RssPodcastIndexTranscript.parse(e);
      }).toList(),
      soundbites: element.findElements("podcast:soundbite").map((e) {
        return new RssPodcastIndexSoundbite.parse(e);
      }).toList(),
    );
  }
}
