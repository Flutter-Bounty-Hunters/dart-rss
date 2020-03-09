import 'dart:io';

import 'package:test/test.dart';
import 'package:webfeed/domain/webfeed.dart';

void main() {
  group('about WebFeed, ', () {
    final atomXmlFile = File('test/xml/Atom.xml');
    final rss1XmlFile = File('test/xml/RSS1-with-dublin-core-module.xml');
    final rss2XmlFile = File('test/xml/RSS.xml');

    String atomXmlString;
    String rss1XmlString;
    String rss2XmlString;

    setUpAll(() async {
      final loadFileFutures = [
        atomXmlFile.readAsString(),
        rss1XmlFile.readAsString(),
        rss2XmlFile.readAsString(),
      ];
      final xmlStrings = await Future.wait(loadFileFutures);
      atomXmlString = xmlStrings[0];
      rss1XmlString = xmlStrings[1];
      rss2XmlString = xmlStrings[2];
    });

    test('it can detect Atom feed.', () {
      final version = WebFeed.detectRssVersion(atomXmlString);
      expect(version, RssVersion.Atom);
    });

    test('it can detect RSS1.0 feed.', () {
      final version = WebFeed.detectRssVersion(rss1XmlString);
      expect(version, RssVersion.RSS1);
    });

    test('it can detect RSS2.0 feed.', () {
      final version = WebFeed.detectRssVersion(rss2XmlString);
      expect(version, RssVersion.RSS2);
    });

    test('it can parse Atom feed.', () {
      // when
      final atomFeed = WebFeed.fromXmlString(atomXmlString);

      // then
      expect(atomFeed.title, 'Foo bar news');
      expect(atomFeed.description, 'This is subtitle');
      expect(atomFeed.links.first, 'http://foo.bar.news/');
      expect(atomFeed.items.first.title, 'Foo bar item 1');
      expect(atomFeed.items.first.body, 'This is summary 1');
      expect(
        atomFeed.items.first.updated,
        DateTime.parse('2018-04-06T13:02:47Z'),
      );
    });

    test('it can parse RSS1.0 feed.', () {
      // when
      final rss1Feed = WebFeed.fromXmlString(rss1XmlString);

      // then
      expect(rss1Feed.title, 'Meerkat');
      expect(rss1Feed.description, 'Meerkat: An Open Wire Service');
      expect(rss1Feed.links.first, 'http://meerkat.oreillynet.com');
      expect(rss1Feed.items.first.title, 'XML: A Disruptive Technology');
      expect(
        rss1Feed.items.first.body,
        'XML is placing increasingly heavy loads on the existing technical infrastructure of the Internet.',
      );
      expect(rss1Feed.items.first.updated, null);
    });

    test('it can parse RSS2.0 feed.', () {
      // when
      final rss2Feed = WebFeed.fromXmlString(rss2XmlString);
      
      // then
      expect(rss2Feed.title, 'News - Foo bar News');
      expect(
        rss2Feed.description,
        'Foo bar News and Updates feed provided by Foo bar, Inc.',
      );
      expect(rss2Feed.links.first, 'https://foo.bar.news/');
      expect(
        rss2Feed.items.first.title,
        'The standard Lorem Ipsum passage, used since the 1500s',
      );
      expect(
        rss2Feed.items.first.body,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      );
      expect(rss2Feed.items.first.updated, null);
    });
  });
}
