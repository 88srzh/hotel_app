import 'dart:async';

import 'package:http/http.dart';

class Network {
  final String url;

  Network(this.url);

  Future<String> getData() async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      return 'Not found';
    } else if (response.statusCode == 500) {
      return 'Server not responding';
    }
    return 'Network error';
  }
}

Future<String> getNetworkData() async {
  // final network = Network('https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3');
  final network = Network('https://run.mocky.io/v3/26b5ca72-566c-4207-b048-1a871c1ac923');
  final networkData = await network.getData();
  return networkData;
}

Future<String> getNetworkDataForRoom() async {
  final network = Network('https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd');
  final networkData = await network.getData();
  return networkData;
}

Future<String> getNetworkDataFromReservation() async {
  final network = Network('https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8');
  final networkData = await network.getData();
  return networkData;
}
