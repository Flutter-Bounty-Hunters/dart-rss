import 'dart:core';
import 'dart:io';

import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/domain/rss_itunes_episode_type.dart';
import 'package:dart_rss/domain/rss_itunes_type.dart';
import 'package:test/test.dart';

void main() {
  test('parse Invalid.xml', () {
    final xmlString = File('test/xml/Invalid.xml').readAsStringSync();

    try {
      RssFeed.parse(xmlString);
      fail('Should throw Argument Error');
    } on ArgumentError {
      // do nothing
    }
  });

  test('parse RSS.xml', () {
    final xmlString = File('test/xml/RSS.xml').readAsStringSync();

    final feed = RssFeed.parse(xmlString);

    expect(feed.title, 'News - Foo bar News');
    expect(feed.description, 'Foo bar News and Updates feed provided by Foo bar, Inc.');
    expect(feed.link, 'https://foo.bar.news/');
    expect(feed.author, 'hello@world.net');
    expect(feed.language, 'en-US');
    expect(feed.lastBuildDate, 'Mon, 26 Mar 2018 14:00:00 PDT');
    expect(feed.generator, 'Custom');
    expect(feed.copyright, 'Copyright 2018, Foo bar Inc.');
    expect(feed.docs, 'https://foo.bar.news/docs');
    expect(feed.managingEditor, 'alice@foo.bar.news');
    expect(feed.rating, 'The PICS rating of the feed');
    expect(feed.webMaster, 'webmaster@foo.bar.news');
    expect(feed.ttl, 60);

    expect(feed.image, isNotNull);
    expect(feed.image!.title, 'Foo bar News');
    expect(feed.image!.url, 'https://foo.bar.news/logo.gif');
    expect(feed.image!.link, 'https://foo.bar.news/');

    expect(feed.cloud, isNotNull);
    expect(feed.cloud!.domain, 'radio.foo.bar.news');
    expect(feed.cloud!.port, '80');
    expect(feed.cloud!.path, '/RPC2');
    expect(feed.cloud!.registerProcedure, 'foo.bar.rssPleaseNotify');
    expect(feed.cloud!.protocol, 'xml-rpc');

    expect(feed.categories.length, 2);
    expect(feed.categories[0].domain, null);
    expect(feed.categories[0].value, 'Ipsum');
    expect(feed.categories[1].domain, 'news');
    expect(feed.categories[1].value, 'Lorem Ipsum');

    expect(feed.skipDays.length, 3);
    expect(feed.skipDays.contains('Monday'), true);
    expect(feed.skipDays.contains('Tuesday'), true);
    expect(feed.skipDays.contains('Sunday'), true);

    expect(feed.skipHours.length, 5);
    expect(feed.skipHours.contains(0), true);
    expect(feed.skipHours.contains(1), true);
    expect(feed.skipHours.contains(2), true);
    expect(feed.skipHours.contains(3), true);
    expect(feed.skipHours.contains(4), true);

    expect(feed.items.length, 2);

    expect(feed.items.first.title, 'The standard Lorem Ipsum passage, used since the 1500s');
    expect(feed.items.first.description, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit');
    expect(feed.items.first.link, 'https://foo.bar.news/1');
    expect(feed.items.first.guid, 'https://foo.bar.news/1?guid');
    expect(feed.items.first.pubDate, 'Mon, 26 Mar 2018 14:00:00 PDT');
    expect(feed.items.first.categories.first.domain, 'news');
    expect(feed.items.first.categories.first.value, 'Lorem');
    expect(feed.items.first.author, 'alice@foo.bar.news');
    expect(feed.items.first.source!.url, 'https://foo.bar.news/1?source');
    expect(feed.items.first.source!.value, 'Foo Bar');
    expect(feed.items.first.comments, 'https://foo.bar.news/1/comments');
    expect(feed.items.first.enclosure!.url, 'http://www.scripting.com/mp3s/weatherReportSuite.mp3');
    expect(feed.items.first.enclosure!.length, 12216320);
    expect(feed.items.first.enclosure!.type, 'audio/mpeg');

    expect(feed.items.first.content!.value,
        '<img width="1000" height="690" src="https://test.com/image_link"/> Test content<br />');
    expect(feed.items.first.content!.images.first, 'https://test.com/image_link');
  });

  test('parse RSS-Media.xml', () {
    final xmlString = File('test/xml/RSS-Media.xml').readAsStringSync();

    final feed = RssFeed.parse(xmlString);
    expect(feed.title, 'Song Site');
    expect(feed.description, 'Media RSS example with new fields added in v1.5.0');

    expect(feed.items.length, 1);

    final item = feed.items.first;
    expect(item.title, null);
    expect(item.link, 'http://www.foo.com');
    expect(item.pubDate, 'Mon, 27 Aug 2001 16:08:56 PST');

    expect(item.media, isNotNull);
    expect(item.media!.group, isNotNull);
    expect(item.media!.group!.contents.length, 5);
    expect(item.media!.group!.credits.length, 2);
    expect(item.media!.group!.category!.value, 'music/artist name/album/song');
    expect(item.media!.group!.rating!.value, 'nonadult');

    expect(item.media!.contents.length, 2);
    final mediaContent = item.media!.contents.first;
    expect(mediaContent.url, 'http://www.foo.com/video.mov');
    expect(mediaContent.type, 'video/quicktime');
    expect(mediaContent.fileSize, 2000);
    expect(mediaContent.medium, 'video');
    expect(mediaContent.isDefault, true);
    expect(mediaContent.expression, 'full');
    expect(mediaContent.bitrate, 128);
    expect(mediaContent.framerate, 25);
    expect(mediaContent.samplingrate, 44.1);
    expect(mediaContent.channels, 2);

    expect(item.media!.credits.length, 2);
    final mediaCredit = item.media!.credits.first;
    expect(mediaCredit.role, 'owner1');
    expect(mediaCredit.scheme, 'urn:yvs');
    expect(mediaCredit.value, 'copyright holder of the entity');

    expect(item.media!.category!.scheme, 'http://search.yahoo.com/mrss/category_ schema');
    expect(item.media!.category!.label, 'Music');
    expect(item.media!.category!.value, 'music/artist/album/song');

    expect(item.media!.rating!.scheme, 'urn:simple');
    expect(item.media!.rating!.value, 'adult');

    expect(item.media!.title!.type, 'plain');
    expect(item.media!.title!.value, "The Judy's -- The Moo Song");

    expect(item.media!.description!.type, 'plain');
    expect(item.media!.description!.value, 'This was some really bizarre band I listened to as a young lad.');

    expect(item.media!.keywords, 'kitty, cat, big dog, yarn, fluffy');

    expect(item.media!.thumbnails.length, 2);
    final mediaThumbnail = item.media!.thumbnails.first;
    expect(mediaThumbnail.url, 'http://www.foo.com/keyframe1.jpg');
    expect(mediaThumbnail.width, '75');
    expect(mediaThumbnail.height, '50');
    expect(mediaThumbnail.time, '12:05:01.123');

    expect(item.media!.hash!.algo, 'md5');
    expect(item.media!.hash!.value, 'dfdec888b72151965a34b4b59031290a');

    expect(item.media!.player!.url, 'http://www.foo.com/player?id=1111');
    expect(item.media!.player!.width, 400);
    expect(item.media!.player!.height, 200);
    expect(item.media!.player!.value, '');

    expect(item.media!.copyright!.url, 'http://blah.com/additional-info.html');
    expect(item.media!.copyright!.value, '2005 FooBar Media');

    expect(item.media!.text!.type, 'plain');
    expect(item.media!.text!.lang, 'en');
    expect(item.media!.text!.start, '00:00:03.000');
    expect(item.media!.text!.end, '00:00:10.000');
    expect(item.media!.text!.value, ' Oh, say, can you see');

    expect(item.media!.restriction!.relationship, 'allow');
    expect(item.media!.restriction!.type, 'country');
    expect(item.media!.restriction!.value, 'au us');

    expect(item.media!.community!.starRating!.average, 3.5);
    expect(item.media!.community!.starRating!.count, 20);
    expect(item.media!.community!.starRating!.min, 1);
    expect(item.media!.community!.starRating!.max, 10);
    expect(item.media!.community!.statistics!.views, 5);
    expect(item.media!.community!.statistics!.favorites, 4);
    expect(item.media!.community!.tags!.tags, 'news: 5, abc:3');
    expect(item.media!.community!.tags!.weight, 1);

    expect(item.media!.comments.length, 2);
    expect(item.media!.comments.first, 'comment1');
    expect(item.media!.comments.last, 'comment2');

    expect(item.media!.embed!.url, 'http://www.foo.com/player.swf');
    expect(item.media!.embed!.width, 512);
    expect(item.media!.embed!.height, 323);
    expect(item.media!.embed!.params.length, 5);
    expect(item.media!.embed!.params.first.name, 'type');
    expect(item.media!.embed!.params.first.value, 'application/x-shockwave-flash');

    expect(item.media!.responses.length, 2);
    expect(item.media!.responses.first, 'http://www.response1.com');
    expect(item.media!.responses.last, 'http://www.response2.com');

    expect(item.media!.backLinks.length, 2);
    expect(item.media!.backLinks.first, 'http://www.backlink1.com');
    expect(item.media!.backLinks.last, 'http://www.backlink2.com');

    expect(item.media!.status!.state, 'active');
    expect(item.media!.status!.reason, null);

    expect(item.media!.prices.length, 2);
    expect(item.media!.prices.first.price, 19.99);
    expect(item.media!.prices.first.type, 'rent');
    expect(item.media!.prices.first.info, 'http://www.dummy.jp/package_info.html');
    expect(item.media!.prices.first.currency, 'EUR');

    expect(item.media!.license!.type, 'text/html');
    expect(item.media!.license!.href, 'http://www.licensehost.com/license');
    expect(item.media!.license!.value, ' Sample license for a video');

    expect(item.media!.peerLink!.type, 'application/x-bittorrent');
    expect(item.media!.peerLink!.href, 'http://www.foo.org/sampleFile.torrent');
    expect(item.media!.peerLink!.value, '');

    expect(item.media!.rights!.status, 'official');

    expect(item.media!.scenes.length, 2);
    expect(item.media!.scenes.first.title, 'sceneTitle1');
    expect(item.media!.scenes.first.description, 'sceneDesc1');
    expect(item.media!.scenes.first.startTime, '00:15');
    expect(item.media!.scenes.first.endTime, '00:45');
  });

  test('parse RSS-DC.xml', () {
    final xmlString = File('test/xml/RSS-DC.xml').readAsStringSync();

    final feed = RssFeed.parse(xmlString);

    expect(feed.dc, isNotNull);
    expect(feed.dc!.title, 'title');
    expect(feed.dc!.creator, 'creator');
    expect(feed.dc!.subject, 'subject');
    expect(feed.dc!.description, 'description');
    expect(feed.dc!.publisher, 'publisher');
    expect(feed.dc!.contributor, 'contributor');
    expect(feed.dc!.date, '2000-01-01T12:00+00:00');
    expect(feed.dc!.type, 'type');
    expect(feed.dc!.format, 'format');
    expect(feed.dc!.identifier, 'identifier');
    expect(feed.dc!.source, 'source');
    expect(feed.dc!.language, 'language');
    expect(feed.dc!.relation, 'relation');
    expect(feed.dc!.coverage, 'coverage');
    expect(feed.dc!.rights, 'rights');

    expect(feed.items, isNotNull);
    expect(feed.items.first.dc!.title, 'title');
    expect(feed.items.first.dc!.creator, 'creator');
    expect(feed.items.first.dc!.subject, 'subject');
    expect(feed.items.first.dc!.description, 'description');
    expect(feed.items.first.dc!.publisher, 'publisher');
    expect(feed.items.first.dc!.contributor, 'contributor');
    expect(feed.items.first.dc!.date, '2000-01-01T12:00+00:00');
    expect(feed.items.first.dc!.type, 'type');
    expect(feed.items.first.dc!.format, 'format');
    expect(feed.items.first.dc!.identifier, 'identifier');
    expect(feed.items.first.dc!.source, 'source');
    expect(feed.items.first.dc!.language, 'language');
    expect(feed.items.first.dc!.relation, 'relation');
    expect(feed.items.first.dc!.coverage, 'coverage');
    expect(feed.items.first.dc!.rights, 'rights');
  });

  test('parse RSS-Empty.xml', () {
    final xmlString = File('test/xml/RSS-Empty.xml').readAsStringSync();

    final feed = RssFeed.parse(xmlString);

    expect(feed.title, null);
    expect(feed.description, null);
    expect(feed.link, null);
    expect(feed.language, null);
    expect(feed.lastBuildDate, null);
    expect(feed.generator, null);
    expect(feed.copyright, null);
    expect(feed.docs, null);
    expect(feed.managingEditor, null);
    expect(feed.rating, null);
    expect(feed.webMaster, null);
    expect(feed.ttl, 0);

    expect(feed.image, null);

    expect(feed.cloud, null);

    expect(feed.categories.length, 0);

    expect(feed.skipDays.length, 0);

    expect(feed.skipHours.length, 0);

    expect(feed.items.length, 1);

    expect(feed.items.first.title, null);
    expect(feed.items.first.description, null);
    expect(feed.items.first.link, null);
    expect(feed.items.first.guid, null);
    expect(feed.items.first.pubDate, null);
    expect(feed.items.first.categories.length, 0);
    expect(feed.items.first.author, null);
    expect(feed.items.first.source, null);
    expect(feed.items.first.comments, null);
    expect(feed.items.first.enclosure, null);

    expect(feed.items.first.content, null);
  });

  test('parse RSS-Itunes.xml', () {
    final xmlString = File('test/xml/RSS-Itunes.xml').readAsStringSync();

    final feed = RssFeed.parse(xmlString);

    expect(feed.itunes, isNotNull);
    expect(feed.itunes!.author, 'Changelog Media');
    expect(feed.itunes!.summary, 'Foo');
    expect(feed.itunes!.explicit, false);
    expect(feed.itunes!.image!.href, 'https://cdn.changelog.com/uploads/covers/go-time-original.png?v=63725770357');
    expect(feed.itunes!.keywords, 'go,golang,open source,software,development'.split(','));
    expect(feed.itunes!.owner!.name, 'Changelog Media');
    expect(feed.itunes!.owner!.email, 'editors@changelog.com');
    expect({feed.itunes!.categories[0]!.category, feed.itunes!.categories[1]!.category}, ['Technology', 'Foo']);
    for (final category in feed.itunes!.categories) {
      switch (category!.category) {
        case 'Foo':
          expect(category.subCategories, ['Bar', 'Baz']);
          break;
        case 'Technology':
          expect(category.subCategories, ['Software How-To', 'Tech News']);
          break;
      }
    }
    expect(feed.itunes!.title, 'Go Time');
    expect(feed.itunes!.type, RssItunesType.serial);
    expect(feed.itunes!.newFeedUrl, 'wubawuba');
    expect(feed.itunes!.block, true);
    expect(feed.itunes!.complete, true);

    final item = feed.items[0];
    expect(item.itunes!.episodeType, RssItunesEpisodeType.full);
    expect(item.itunes!.episode, 1);
    expect(item.itunes!.season, 1);
    expect(item.itunes!.image!.href, 'https://cdn.changelog.com/uploads/covers/go-time-original.png?v=63725770357');
    expect(item.itunes!.duration, const Duration(minutes: 32, seconds: 30));
    expect(item.itunes!.explicit, false);
    expect(item.itunes!.keywords, 'go,golang,open source,software,development'.split(','));
    expect(item.itunes!.subtitle, 'with Erik, Carlisia, and Brian');
    expect(item.itunes!.summary, 'Foo');
    expect(item.itunes!.author, 'Erik St. Martin, Carlisia Pinto, and Brian Ketelsen');
    expect(item.itunes!.explicit, false);
    expect(item.itunes!.title, 'awesome title');
    expect(item.itunes!.block, false);
  });

  test('parse RSS-PodcastIndex-R1.xml', () {
    var xmlString = File('test/xml/RSS-PodcastIndex-R1.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);
    var podcastPersons = feed.podcastIndex!.persons;

    expect(feed.title, 'Podcasting 2.0 Namespace Example');
    expect(
        feed.description, 'This is a fake show that exists only as an example of the "podcast" namespace tag usage.');
    expect(feed.link, 'http://example.com/podcast');
    expect(feed.language, 'en-US');
    expect(feed.lastBuildDate, 'Fri, 09 Oct 2020 04:30:38 GMT');
    expect(feed.generator, 'Freedom Controller');
    expect(feed.webMaster, 'support@example.com (Tech Support)');
    expect(podcastPersons?.length, 2);
    expect(podcastPersons![0]?.name, 'Host 1 Podcast');
    expect(podcastPersons[1]?.name, 'Host 2 Podcast');

    expect(feed.podcastIndex!.locked!.locked, true);
    expect(feed.podcastIndex!.locked!.owner, 'podcastowner@example.com');
    expect(feed.podcastIndex!.funding![0]!.url, 'https://example.com/donate');
    expect(feed.podcastIndex!.funding![0]!.value, 'Support the show!');
    expect(feed.podcastIndex!.funding![1]!.url, 'https://example.com/member');
    expect(feed.podcastIndex!.funding![1]!.value, 'Become a member!');

    expect(feed.podcastIndex!.liveItems, isNotNull);
    expect(feed.podcastIndex!.liveItems!.length, 3);
    _verifyLiveItem0(feed.podcastIndex!.liveItems![0]!);
    _verifyLiveItem1(feed.podcastIndex!.liveItems![1]!);
    _verifyLiveItem2(feed.podcastIndex!.liveItems![2]!);

    var item1 = feed.items[0];
    var transcripts1 = item1.podcastIndex!.transcripts;
    var soundbite1 = item1.podcastIndex!.soundbites;
    var chapters1 = item1.podcastIndex!.chapters;
    var itemsPersons = item1.podcastIndex!.persons;

    expect(transcripts1.length, 1);
    expect(transcripts1[0]!.url, 'https://example.com/ep3/transcript.txt');
    expect(transcripts1[0]!.type, 'text/plain');
    expect(chapters1?.url, 'https://example.com/ep3_chapters.json');
    expect(chapters1?.type, 'application/json');
    expect(itemsPersons.length, 2);
    expect(itemsPersons[0]?.name, 'Host 1 Item');
    expect(itemsPersons[1]?.name, 'Host 2 Item');

    expect(soundbite1.length, 1);
    expect(soundbite1[0]!.startTime, 33.833);
    expect(soundbite1[0]!.duration, 60.0);

    var item2 = feed.items[1];
    var transcripts2 = item2.podcastIndex!.transcripts;
    var soundbite2 = item2.podcastIndex!.soundbites;
    var chapters2 = item2.podcastIndex!.chapters;

    expect(transcripts2.length, 1);
    expect(transcripts2[0]!.url, 'https://example.com/ep2/transcript.txt');
    expect(transcripts2[0]!.type, 'text/plain');
    expect(chapters2?.url, 'https://example.com/ep2_chapters.json');
    expect(chapters2?.type, 'application/json');

    expect(soundbite2.length, 1);
    expect(soundbite2[0]!.startTime, 45.4);
    expect(soundbite2[0]!.duration, 56.0);
  });

  group("serializes RSS 2 >", () {
    test("smoke test", () {
      const feed = RssFeed(
        title: "Blog | Flutter Bounty Hunters",
        description: "The Flutter Bounty Hunters blog.",
        language: "en-us",
        pubDate: "22 Nov 2022",
        docs: "http://blogs.law.harvard.edu/tech/rss",
        items: [
          RssItem(
            title: "We launched a new blog!",
            link: "https://blog.flutterbountyhunters.com/we-launched-a-new-blog",
            description: "The Flutter Bounty Hunters just launched a new blog. Check it out.",
            pubDate: "22 Nov 2022",
            guid: "/we-launched-a-new-blog",
          ),
          RssItem(
            title: "10 Things the Flutter Team Should do in 2023",
            link: "https://blog.flutterbountyhunters.com/ten-things-the-flutter-team-should-do-in-2023",
            description: "Here's our selection of the top 10 things that we think the Flutter team should do in 2023.",
            pubDate: "20 Dec 2022",
            guid: "/ten-things-the-flutter-team-should-do-in-2023",
          ),
        ],
      );

      expect(
        feed.toXmlDocument().toXmlString(pretty: true, indent: "  "),
        '''<rss version="2.0">
  <channel>
    <title>Blog | Flutter Bounty Hunters</title>
    <description>The Flutter Bounty Hunters blog.</description>
    <language>en-us</language>
    <pubDate>22 Nov 2022</pubDate>
    <docs>http://blogs.law.harvard.edu/tech/rss</docs>
    <item>
      <title>We launched a new blog!</title>
      <link>https://blog.flutterbountyhunters.com/we-launched-a-new-blog</link>
      <description>The Flutter Bounty Hunters just launched a new blog. Check it out.</description>
      <pubDate>22 Nov 2022</pubDate>
      <guid>/we-launched-a-new-blog</guid>
    </item>
    <item>
      <title>10 Things the Flutter Team Should do in 2023</title>
      <link>https://blog.flutterbountyhunters.com/ten-things-the-flutter-team-should-do-in-2023</link>
      <description>Here's our selection of the top 10 things that we think the Flutter team should do in 2023.</description>
      <pubDate>20 Dec 2022</pubDate>
      <guid>/ten-things-the-flutter-team-should-do-in-2023</guid>
    </item>
  </channel>
</rss>''',
      );
    });
  });
}

void _verifyLiveItem0(RssPodcastIndexLiveItem liveItem) {
  expect(liveItem.status, "pending");
  expect(liveItem.start, "2025-05-14T13:00:00.000-0800");
  expect(liveItem.end, isNull);
  expect(liveItem.title, "A Future Show");
  expect(liveItem.description, "This entry represents a show that will happen in the future.");
  expect(liveItem.link, "https://example.com/podcast/live");
  expect(liveItem.guid!.isPermalink, true);
  expect(liveItem.guid!.value, "https://example.com/live");
  expect(liveItem.author, "John Doe (john@example.com)");
  expect(liveItem.images, isNotNull);
  // TODO: check image parsing and find out why it doesn't support our situation
  // expect(
  //   liveItem.images!.urls,
  //   "https://example.com/images/live/pci_avatar-massive.jpg 1500w, https://example.com/images/live/pci_avatar-middle.jpg 600w, https://example.com/images/live/pci_avatar-small.jpg 300w, https://example.com/images/live/pci_avatar-tiny.jpg 150w",
  // );

  // <podcast:images srcset="https://example.com/images/live/pci_avatar-massive.jpg 1500w,
  // https://example.com/images/live/pci_avatar-middle.jpg 600w,
  // https://example.com/images/live/pci_avatar-small.jpg 300w,
  // https://example.com/images/live/pci_avatar-tiny.jpg 150w"
  // />
  expect(liveItem.persons!.length, 3);
  expect(liveItem.persons![0].name, "Adam Curry");
  expect(liveItem.persons![0].link, "https://www.podchaser.com/creators/adam-curry-107ZzmWE5f");
  expect(liveItem.persons![0].image, "https://example.com/images/adamcurry.jpg");

  expect(liveItem.persons![1].name, "Dave Jones");
  expect(liveItem.persons![1].link, "https://github.com/daveajones/");
  expect(liveItem.persons![1].image, "https://example.com/images/davejones.jpg");
  expect(liveItem.persons![1].role, "guest");

  expect(liveItem.persons![2].name, "Becky Smith");
  expect(liveItem.persons![2].link, "https://example.com/artist/beckysmith");
  expect(liveItem.persons![2].group, "visuals");
  expect(liveItem.persons![2].role, "cover art designer");

  expect(liveItem.alternateEnclosure, isNotNull);
  expect(liveItem.alternateEnclosure!.type, "audio/mpeg");
  expect(liveItem.alternateEnclosure!.length, 312);
  expect(liveItem.alternateEnclosure!.isDefault, true);
  // TODO: test the rest of the alernativeEnclosure when we finish modeling it (#43)

  expect(liveItem.enclosure, isNotNull);
  expect(liveItem.enclosure!.url, "https://example.com/pc20/livestream?format=.mp3");
  expect(liveItem.enclosure!.type, "audio/mpeg");
  expect(liveItem.enclosure!.length, 312);

  expect(liveItem.contentLinks, isNotNull);
  expect(liveItem.contentLinks!.length, 3);
  expect(liveItem.contentLinks![0].href, "https://youtube.com/pc20/livestream");
  expect(liveItem.contentLinks![0].value, "YouTube!");
  expect(liveItem.contentLinks![1].href, "https://twitch.com/pc20/livestream");
  expect(liveItem.contentLinks![1].value, "Twitch!");
  expect(liveItem.contentLinks![2].href, "https://example.com/html/livestream");
  expect(liveItem.contentLinks![2].value, "Listen Live!");
}

void _verifyLiveItem1(RssPodcastIndexLiveItem liveItem) {
  expect(liveItem.status, "live");
  expect(liveItem.start, "2023-01-13T13:00:00.000-0800");
  expect(liveItem.end, isNull);
  expect(liveItem.title, "An In-Progress Show");
  expect(liveItem.description, "This entry represents a show that's happening right now.");
  expect(liveItem.link, "https://example.com/podcast/live");
  expect(liveItem.guid!.isPermalink, true);
  expect(liveItem.guid!.value, "https://example.com/live");
  expect(liveItem.author, "John Doe (john@example.com)");
  expect(liveItem.images, isNotNull);
  // TODO: check image parsing and find out why it doesn't support our situation
  // expect(
  //   liveItem.images!.urls,
  //   "https://example.com/images/live/pci_avatar-massive.jpg 1500w, https://example.com/images/live/pci_avatar-middle.jpg 600w, https://example.com/images/live/pci_avatar-small.jpg 300w, https://example.com/images/live/pci_avatar-tiny.jpg 150w",
  // );

  // <podcast:images srcset="https://example.com/images/live/pci_avatar-massive.jpg 1500w,
  // https://example.com/images/live/pci_avatar-middle.jpg 600w,
  // https://example.com/images/live/pci_avatar-small.jpg 300w,
  // https://example.com/images/live/pci_avatar-tiny.jpg 150w"
  // />
  expect(liveItem.persons!.length, 3);
  expect(liveItem.persons![0].name, "Adam Curry");
  expect(liveItem.persons![0].link, "https://www.podchaser.com/creators/adam-curry-107ZzmWE5f");
  expect(liveItem.persons![0].image, "https://example.com/images/adamcurry.jpg");

  expect(liveItem.persons![1].name, "Dave Jones");
  expect(liveItem.persons![1].link, "https://github.com/daveajones/");
  expect(liveItem.persons![1].image, "https://example.com/images/davejones.jpg");
  expect(liveItem.persons![1].role, "guest");

  expect(liveItem.persons![2].name, "Becky Smith");
  expect(liveItem.persons![2].link, "https://example.com/artist/beckysmith");
  expect(liveItem.persons![2].group, "visuals");
  expect(liveItem.persons![2].role, "cover art designer");

  expect(liveItem.alternateEnclosure, isNotNull);
  expect(liveItem.alternateEnclosure!.type, "audio/mpeg");
  expect(liveItem.alternateEnclosure!.length, 312);
  expect(liveItem.alternateEnclosure!.isDefault, true);
  // TODO: test the rest of the alernativeEnclosure when we finish modeling it (#43)

  expect(liveItem.enclosure, isNotNull);
  expect(liveItem.enclosure!.url, "https://example.com/pc20/livestream?format=.mp3");
  expect(liveItem.enclosure!.type, "audio/mpeg");
  expect(liveItem.enclosure!.length, 312);

  expect(liveItem.contentLinks, isNotNull);
  expect(liveItem.contentLinks!.length, 3);
  expect(liveItem.contentLinks![0].href, "https://youtube.com/pc20/livestream");
  expect(liveItem.contentLinks![0].value, "YouTube!");
  expect(liveItem.contentLinks![1].href, "https://twitch.com/pc20/livestream");
  expect(liveItem.contentLinks![1].value, "Twitch!");
  expect(liveItem.contentLinks![2].href, "https://example.com/html/livestream");
  expect(liveItem.contentLinks![2].value, "Listen Live!");
}

void _verifyLiveItem2(RssPodcastIndexLiveItem liveItem) {
  expect(liveItem.status, "ended");
  expect(liveItem.start, "2020-08-26T13:00:00.000-0800");
  expect(liveItem.end, "2020-08-26T15:00:00.000-0800");
  expect(liveItem.title, "A Completed Show");
  expect(liveItem.description, "This entry represents a show that was recorded in the past.");
  expect(liveItem.link, "https://example.com/podcast/live");
  expect(liveItem.guid!.isPermalink, true);
  expect(liveItem.guid!.value, "https://example.com/live");
  expect(liveItem.author, "John Doe (john@example.com)");
  expect(liveItem.images, isNotNull);
  // TODO: check image parsing and find out why it doesn't support our situation
  // expect(
  //   liveItem.images!.urls,
  //   "https://example.com/images/live/pci_avatar-massive.jpg 1500w, https://example.com/images/live/pci_avatar-middle.jpg 600w, https://example.com/images/live/pci_avatar-small.jpg 300w, https://example.com/images/live/pci_avatar-tiny.jpg 150w",
  // );

  // <podcast:images srcset="https://example.com/images/live/pci_avatar-massive.jpg 1500w,
  // https://example.com/images/live/pci_avatar-middle.jpg 600w,
  // https://example.com/images/live/pci_avatar-small.jpg 300w,
  // https://example.com/images/live/pci_avatar-tiny.jpg 150w"
  // />
  expect(liveItem.persons!.length, 3);
  expect(liveItem.persons![0].name, "Adam Curry");
  expect(liveItem.persons![0].link, "https://www.podchaser.com/creators/adam-curry-107ZzmWE5f");
  expect(liveItem.persons![0].image, "https://example.com/images/adamcurry.jpg");

  expect(liveItem.persons![1].name, "Dave Jones");
  expect(liveItem.persons![1].link, "https://github.com/daveajones/");
  expect(liveItem.persons![1].image, "https://example.com/images/davejones.jpg");
  expect(liveItem.persons![1].role, "guest");

  expect(liveItem.persons![2].name, "Becky Smith");
  expect(liveItem.persons![2].link, "https://example.com/artist/beckysmith");
  expect(liveItem.persons![2].group, "visuals");
  expect(liveItem.persons![2].role, "cover art designer");

  expect(liveItem.alternateEnclosure, isNotNull);
  expect(liveItem.alternateEnclosure!.type, "audio/mpeg");
  expect(liveItem.alternateEnclosure!.length, 312);
  expect(liveItem.alternateEnclosure!.isDefault, true);
  // TODO: test the rest of the alernativeEnclosure when we finish modeling it (#43)

  expect(liveItem.enclosure, isNotNull);
  expect(liveItem.enclosure!.url, "https://example.com/pc20/livestream?format=.mp3");
  expect(liveItem.enclosure!.type, "audio/mpeg");
  expect(liveItem.enclosure!.length, 312);

  expect(liveItem.contentLinks, isNotNull);
  expect(liveItem.contentLinks!.length, 3);
  expect(liveItem.contentLinks![0].href, "https://youtube.com/pc20/livestream");
  expect(liveItem.contentLinks![0].value, "YouTube!");
  expect(liveItem.contentLinks![1].href, "https://twitch.com/pc20/livestream");
  expect(liveItem.contentLinks![1].value, "Twitch!");
  expect(liveItem.contentLinks![2].href, "https://example.com/html/livestream");
  expect(liveItem.contentLinks![2].value, "Listen Live!");
}
