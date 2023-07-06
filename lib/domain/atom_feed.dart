import 'package:dart_rss/domain/atom_category.dart';
import 'package:dart_rss/domain/atom_generator.dart';
import 'package:dart_rss/domain/atom_item.dart';
import 'package:dart_rss/domain/atom_link.dart';
import 'package:dart_rss/domain/atom_person.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomFeed {
  final String? id;
  final String? title;
  final String? updated;
  final List<AtomItem> items;

  final List<AtomLink> links;
  final List<AtomPerson> authors;
  final List<AtomPerson> contributors;
  final List<AtomCategory> categories;
  final AtomGenerator? generator;
  final String? icon;
  final String? logo;
  final String? rights;
  final String? subtitle;

  const AtomFeed({
    this.id,
    this.title,
    this.updated,
    this.items = const <AtomItem>[],
    this.links = const <AtomLink>[],
    this.authors = const <AtomPerson>[],
    this.contributors = const <AtomPerson>[],
    this.categories = const <AtomCategory>[],
    this.generator,
    this.icon,
    this.logo,
    this.rights,
    this.subtitle,
  });

  factory AtomFeed.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    XmlElement feedElement;
    try {
      feedElement = document.findElements('feed').first;
    } on StateError {
      throw ArgumentError('feed not found');
    }

    return AtomFeed(
      id: findElementOrNull(feedElement, 'id')?.innerText,
      title: findElementOrNull(feedElement, 'title')?.innerText,
      updated: findElementOrNull(feedElement, 'updated')?.innerText,
      items: feedElement
          .findElements('entry')
          .map((element) => AtomItem.parse(element))
          .toList(),
      links: feedElement
          .findElements('link')
          .map((element) => AtomLink.parse(element))
          .toList(),
      authors: feedElement
          .findElements('author')
          .map((element) => AtomPerson.parse(element))
          .toList(),
      contributors: feedElement
          .findElements('contributor')
          .map((element) => AtomPerson.parse(element))
          .toList(),
      categories: feedElement
          .findElements('category')
          .map((element) => AtomCategory.parse(element))
          .toList(),
      generator:
          AtomGenerator.parse(findElementOrNull(feedElement, 'generator')),
      icon: findElementOrNull(feedElement, 'icon')?.innerText,
      logo: findElementOrNull(feedElement, 'logo')?.innerText,
      rights: findElementOrNull(feedElement, 'rights')?.innerText,
      subtitle: findElementOrNull(feedElement, 'subtitle')?.innerText,
    );
  }
}
