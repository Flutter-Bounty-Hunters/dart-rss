import 'package:dart_rss/dart_rss.dart';
import 'package:test/test.dart';

void main() {
  group('about SafeParseDateTime, ', () {
    test('it can parse ISO-8601', () {
      final date = SafeParseDateTime.safeParse('2018-04-06T13:02:47Z')!;

      expect(date.year, 2018);
      expect(date.month, 4);
      expect(date.day, 6);
    });

    test('it can parse American-English-Format', () {
      final date =
          SafeParseDateTime.safeParse('Tue, 02 Jul 2019 16:47:24 +0000')!;

      expect(date.year, 2019);
      expect(date.month, 7);
      expect(date.day, 2);
    });

    test('incorrect date returns null', () {
      final date = SafeParseDateTime.safeParse('Tue 12');
      expect(date, null);
    });
  });
}
