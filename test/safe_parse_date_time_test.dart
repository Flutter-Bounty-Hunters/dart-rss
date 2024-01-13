import 'package:dart_rss/util/helpers.dart';
import 'package:test/test.dart';

void main() {
  group('SafeParseDateTime, ', () {
    test('parses ISO-8601', () {
      final date = SafeParseDateTime.safeParse('2018-04-06T13:02:47Z')!;

      expect(date.year, 2018);
      expect(date.month, 4);
      expect(date.day, 6);
    });

    test('parses American-English-Format', () {
      final date = SafeParseDateTime.safeParse('Tue, 02 Jul 2019 16:47:24 +0000')!;

      expect(date.year, 2019);
      expect(date.month, 7);
      expect(date.day, 2);
    });

    test('returns null for incorrect dates', () {
      final date = SafeParseDateTime.safeParse('Tue 12');
      expect(date, null);
    });

    test('parses dates with trailing whitespaces', () {
      final date = SafeParseDateTime.safeParse('2024-01-08T00:19:00Z ')!;

      expect(date, DateTime.utc(2024, 1, 8, 0, 19, 0));
    });
  });
}
