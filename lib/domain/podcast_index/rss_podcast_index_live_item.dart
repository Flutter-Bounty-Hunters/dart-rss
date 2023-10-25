import 'package:dart_rss/domain/podcast_index/rss_podcast_index_alternate_enclosure.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_content_link.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_guid.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_index_person.dart';
import 'package:dart_rss/domain/podcast_index/rss_podcast_live_item_images.dart';
import 'package:dart_rss/domain/rss_enclosure.dart';
import 'package:dart_rss/domain/rss_itunes_image.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexLiveItem {
  static RssPodcastIndexLiveItem? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexLiveItem(
      //elements
      title: findElementOrNull(element, "title")?.innerText,
      description: findElementOrNull(element, "description")?.innerText,
      link: findElementOrNull(element, "link")?.innerText,
      author: findElementOrNull(element, "author")?.innerText,

      // attributes
      status: element.getAttribute("status"),
      start: element.getAttribute("start"),
      end: element.getAttribute("end"),

      // classes
      guid: RssPodcastIndexGuid.parse(findElementOrNull(element, "guid")),

      images: RssPodcastIndexLiveItemImages.parse(findElementOrNull(element, "podcast:images")),

      itunesImage: RssItunesImage.parse(findElementOrNull(element, "itunes:image")),
      alternateEnclosure:
          RssPodcastIndexAlternateEnclosure.parse(findElementOrNull(element, "podcast:alternateEnclosure")),

      persons: element.findElements('podcast:person').map((e) => RssPodcastIndexPerson.parse(e)).toList(),
      enclosure: RssEnclosure.parse(findElementOrNull(element, "enclosure")),

      contentLinks:
          element.findElements('podcast:contentLink').map((e) => RssPodcastIndexContentLink.parse(e)).toList(),
    );
  }

  const RssPodcastIndexLiveItem({
    this.title,
    this.description,
    this.link,
    this.author,
    this.status,
    this.start,
    this.end,
    this.guid,
    this.images,
    this.itunesImage,
    this.alternateEnclosure,
    this.persons,
    this.enclosure,
    this.contentLinks,
  });

  final String? title;
  final String? description;
  final String? link;
  final String? author;

  final String? status;
  final String? start;
  final String? end;

  final RssPodcastIndexGuid? guid;
  final RssPodcastIndexLiveItemImages? images;
  final RssItunesImage? itunesImage;
  final RssPodcastIndexAlternateEnclosure? alternateEnclosure;
  final List<RssPodcastIndexPerson>? persons;
  final RssEnclosure? enclosure;
  final List<RssPodcastIndexContentLink>? contentLinks;

  @override
  String toString() {
    return 'RssPodcastIndexLiveItem{title: $title, description: $description, link: $link, author: $author, status: $status, start: $start, end: $end, guid: $guid, images: $images, alternateEnclosure: $alternateEnclosure, persons: $persons, enclosure: $enclosure, contentLinks: $contentLinks}';
  }
}
