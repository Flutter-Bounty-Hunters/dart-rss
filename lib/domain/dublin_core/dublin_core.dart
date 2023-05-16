import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class DublinCore {
  final String? title;
  final String? description;
  final String? creator;
  final String? subject;
  final List<String> subjects;
  final String? publisher;
  final String? contributor;
  final String? date;
  final String? type;
  final String? format;
  final String? identifier;
  final String? source;
  final String? language;
  final String? relation;
  final String? coverage;
  final String? rights;

  const DublinCore({
    this.title,
    this.description,
    this.creator,
    this.subject,
    this.subjects = const <String>[],
    this.publisher,
    this.contributor,
    this.date,
    this.type,
    this.format,
    this.identifier,
    this.source,
    this.language,
    this.relation,
    this.coverage,
    this.rights,
  });

  factory DublinCore.parse(XmlElement element) {
    final subjects = findAllDirectElementsOrNull(element, 'dc:subject');
    return DublinCore(
      title: findElementOrNull(element, 'dc:title')?.value,
      description: findElementOrNull(element, 'dc:description')?.value,
      creator: findElementOrNull(element, 'dc:creator')?.value,
      subject: findElementOrNull(element, 'dc:subject')?.value,
      subjects: subjects == null
          ? <String>[]
          : subjects
              .where((element) => element.value != null)
              .map((subjectElement) => subjectElement.value!)
              .toList(),
      publisher: findElementOrNull(element, 'dc:publisher')?.value,
      contributor: findElementOrNull(element, 'dc:contributor')?.value,
      date: findElementOrNull(element, 'dc:date')?.value,
      type: findElementOrNull(element, 'dc:type')?.value,
      format: findElementOrNull(element, 'dc:format')?.value,
      identifier: findElementOrNull(element, 'dc:identifier')?.value,
      source: findElementOrNull(element, 'dc:source')?.value,
      language: findElementOrNull(element, 'dc:language')?.value,
      relation: findElementOrNull(element, 'dc:relation')?.value,
      coverage: findElementOrNull(element, 'dc:coverage')?.value,
      rights: findElementOrNull(element, 'dc:rights')?.value,
    );
  }
}
