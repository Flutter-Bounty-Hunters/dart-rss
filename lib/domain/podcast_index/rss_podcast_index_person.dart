import 'package:xml/xml.dart';

/// This class represents a person that is linked to a podcast or individual
/// episode.
///
/// Persons can be defined at the podcast and episode level. If a person is
/// defined at the episode level, this overrides all and any persons defined at
/// the [RssItem] level.
class RssPodcastIndexPerson {
  /// The person's name.
  String name;

  /// Their role within the podcast or individual episode.
  String? role;

  /// This should be a reference to an official group within the Podcast Taxonomy Project list.
  /// If group is not present, then "cast" is assumed.
  String? group;

  /// The person's avatar/image.
  String? image;

  /// The url to a relevant resource of information about the person, such as a homepage or
  /// third-party profile platform.
  String? link;

  RssPodcastIndexPerson({
    required this.name,
    this.role,
    this.group,
    this.image,
    this.link,
  });

  factory RssPodcastIndexPerson.parse(XmlElement element) {
    final role = element.getAttribute('role');
    final group = element.getAttribute('group');
    final image = element.getAttribute('img');
    final link = element.getAttribute('href');
    final name = element.innerText.trim();

    return RssPodcastIndexPerson(
      name: name,
      role: role,
      group: group,
      image: image,
      link: link,
    );
  }
}
