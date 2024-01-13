import 'dart:core';

import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

XmlElement? findElementOrNull(XmlElement element, String name, {String? namespace}) {
  try {
    return element.findAllElements(name, namespace: namespace).first;
  } on StateError {
    return null;
  }
}

List<XmlElement>? findAllDirectElementsOrNull(XmlElement element, String name, {String? namespace}) {
  try {
    return element.findElements(name, namespace: namespace).toList();
  } on StateError {
    return null;
  }
}

bool? parseBoolLiteral(XmlElement element, String tagName) {
  final v = findElementOrNull(element, tagName)?.innerText.toLowerCase().trim();
  if (v == null) {
    return null;
  }
  return ['yes', 'true'].contains(v);
}

bool? parseBool(String? v) {
  if (v == null) {
    return null;
  }
  return ['yes', 'true'].contains(v);
}

extension SafeParseDateTime on DateTime {
  static DateTime? safeParse(String? str) {
    if (str == null) {
      return null;
    }

    const dateFormatPatterns = [
      'EEE, d MMM yyyy HH:mm:ss Z',
    ];

    // DateTime.parse returns null if the input has
    // trailing spaces. Remove the spaces to avoid that.
    final trimmedDate = str.trim();
    try {
      return DateTime.parse(trimmedDate);
    } catch (_) {
      for (final pattern in dateFormatPatterns) {
        try {
          final format = DateFormat(pattern);
          return format.parse(trimmedDate);
        } catch (_) {}
      }
    }
    return null;
  }
}

DateTime? parseDateTime(String? dateTimeString) {
  if (dateTimeString == null) {
    return null;
  }
  return DateTime.tryParse(dateTimeString);
}

int? parseInt(String? intString) {
  if (intString == null) {
    return null;
  }
  return int.tryParse(intString);
}
