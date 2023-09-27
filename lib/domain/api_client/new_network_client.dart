import 'dart:convert';

import 'package:hotel_app/domain/entity/hotel.dart';
import 'package:http/http.dart' as http;

List<Hotel> parseHotel(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Hotel>((json) => Hotel.fromJson(json)).toList();
}

Future<List<Hotel>> fetchData(http.Client client) async {
  final response = await client.get(Uri.parse('https://https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));
  return parseHotel(response.body);
}
