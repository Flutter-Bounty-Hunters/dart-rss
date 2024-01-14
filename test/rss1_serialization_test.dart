import 'dart:io';

import 'package:dart_rss/dart_rss.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("RSS 1 >", () {
    test("serialization >", () {
      final feed = Rss1Feed.parse(
        File('test/xml/RSS1-basic.xml').readAsStringSync(),
      );

      final xml = feed.toXmlDocument();
      print(xml.toXmlString(pretty: true));
    });
  });
}
