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
        case 3:
          if (kDebugMode) {
            print('Authentication failed: You do not have permissions to access the service.');
          }
          throw ApiClientException(ApiClientExceptionType.sessionExpired);
        case 7:
          if (kDebugMode) {
            print('Invalid API key: You must be granted a valid key.');
          }
          break;
        case 10:
          if (kDebugMode) {
            print('Suspended APU key: Access to  your account has been suspended, contact TMDB.');
          }
          break;
        case 14:
          if (kDebugMode) {
            print('Authentication failed.');
          }
          break;
        case 32:
          if (kDebugMode) {
            print('Email not verified: Your email address has not been verified.');
          }
          break;
        case 33:
          if (kDebugMode) {
            print('Invalid request token: The request token is either expired or invalid.');
          }
          break;
        case 35:
          if (kDebugMode) {
            print('Invalid token.');
          }
          break;
        case 36:
          if (kDebugMode) {
            print('This token hasnt been granted write permission by the user.');
            break;
          }
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
        //   final result = value.join();
        //   return result;
        // })
        .then<dynamic>((v) => json.decode(v));
  }
}
