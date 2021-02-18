import 'package:dart_rss/dart_rss.dart';
import 'package:test/test.dart';

void main() {
  group('Can this library use for real rss xml?', () {
    const testFeeds = {
      'pub.dev feed': 'https://pub.dev/feed.atom',
      'Flutter Weekly':
          'https://us17.campaign-archive.com/feed?u=c8d8d18b6e2c6316ddc1d48a0&id=47548a283b',
      'jQuery blog': 'http://blog.jquery.com/feed/', // <- not use ISO8601
      'hatena sample': 'https://b.hatena.ne.jp/sample/bookmark.rss', // <- RSS1
    };

    for (final title in testFeeds.keys) {
      final url = testFeeds[title]!;
      test(title, () async {
        // given
        final feed = await WebFeed.fromUrl(url);

        // then
        expect(feed.title.isNotEmpty, true);
        expect(feed.items.first.updated is DateTime, true);
        expect(feed.items.first.links.isNotEmpty, true);
      });
    }
  });
}
