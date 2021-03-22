import 'package:xml/xml.dart';

class RssCloud {
  final String? domain;
  final String? port;
  final String? path;
  final String? registerProcedure;
  final String? protocol;

  const RssCloud(
    this.domain,
    this.port,
    this.path,
    this.registerProcedure,
    this.protocol,
  );

  static RssCloud? parse(XmlElement? node) {
    if (node == null) {
      return null;
    }
    final domain = node.getAttribute('domain');
    final port = node.getAttribute('port');
    final path = node.getAttribute('path');
    final registerProcedure = node.getAttribute('registerProcedure');
    final protocol = node.getAttribute('protocol');
    return RssCloud(domain, port, path, registerProcedure, protocol);
  }
}
