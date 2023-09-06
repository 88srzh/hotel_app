import 'dart:io';
import 'dart:convert';

import 'package:hotel_app/configuration/configuration.dart';

class NetworkClient {
  final _client = HttpClient();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${Configuration.host}$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> get<T> (
    String path;
    T Function(dynamic json) parser, [
      Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    final request = await _client.getUrl(url);
    final response = await request.close();
    final dynamic json = (await response.jsonDecode());

  }

}