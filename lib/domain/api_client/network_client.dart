import 'dart:async';

import 'package:http/http.dart';

class Network {
  final String url;

  Network(this.url);

  Future<String> getData() async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'network error';
    }
  }
}

Future<String> getNetworkData() async {
  final network = Network('https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3');
  final networkData = await network.getData();
  return networkData;
}
