import 'dart:io';
import 'dart:convert';

import 'package:hotel_app/configuration/configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel_app/domain/api_client/api_client_exception.dart';

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

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    final request = await _client.getUrl(url);
    final response = await request.close();
    final dynamic json = (await response.jsonDecode());
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
    _validateResponse(response, json);
    final result = parser(json);
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      switch (code) {
        case 30:
          if (kDebugMode) {
            print('Invalid username and/or password: You did not provide a valid login.');
          }
          throw ApiClientException(ApiClientExceptionType.auth);
      }
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        // .then((value) {
        // final result = value.join();
        // return result;
        // })
        .then<dynamic>((v) => json.decode(v));
  }
}
