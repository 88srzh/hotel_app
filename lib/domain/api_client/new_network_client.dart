import 'package:http/http.dart' as http;

Future<http.Response> fetchData(http.Client client) async {
  return client.get(Uri.parse('https://https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));
}