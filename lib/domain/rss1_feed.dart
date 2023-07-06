import 'dart:core';

import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/rss1_item.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

enum UpdatePeriod {
  hourly,
  daily,
  weekly,
  monthly,
  yearly,
}

class Rss1Feed {
  final String? title;
  final String? description;
  final String? link;
  final String? image;
  final List<Rss1Item> items;
  final UpdatePeriod? updatePeriod;
  final int? updateFrequency;
  final DateTime? updateBase;
  final DublinCore? dc;

  Rss1Feed({
    this.title,
    this.description,
    this.link,
    this.items = const <Rss1Item>[],
    this.image,
    this.updatePeriod,
    this.updateFrequency,
    this.updateBase,
    this.dc,
  });

  static UpdatePeriod? _parseUpdatePeriod(String? updatePeriodString) {
    switch (updatePeriodString) {
      case 'hourly':
        return UpdatePeriod.hourly;
      case 'daily':
        return UpdatePeriod.daily;
      case 'weekly':
        return UpdatePeriod.weekly;
      case 'monthly':
        return UpdatePeriod.monthly;
      case 'yearly':
        return UpdatePeriod.yearly;
      default:
        return null;
    }
  }

  factory Rss1Feed.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    XmlElement rdfElement;
    try {
      rdfElement = document.findAllElements('rdf:RDF').first;
    } on StateError {
      throw ArgumentError('channel not found');
    }

    final channel = rdfElement.findElements('channel');
    return Rss1Feed(
      title: findElementOrNull(rdfElement, 'title')?.innerText,
      link: findElementOrNull(rdfElement, 'link')?.innerText,
      description: findElementOrNull(rdfElement, 'description')?.innerText,
      items: rdfElement.findElements('item').map((element) => Rss1Item.parse(element)).toList(),
      image: findElementOrNull(rdfElement, 'image')?.getAttribute('rdf:resource'),
      updatePeriod: _parseUpdatePeriod(findElementOrNull(rdfElement, 'sy:updatePeriod')?.innerText,),
      updateFrequency: parseInt(findElementOrNull(rdfElement, 'sy:updateFrequency')?.innerText,),
      updateBase: parseDateTime(findElementOrNull(rdfElement, 'sy:updateBase')?.innerText,),
      dc: channel.isEmpty ? null : DublinCore.parse(rdfElement.findElements('channel').first),
    );
  }
}
