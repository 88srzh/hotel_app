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

Future<String> getNetworkDataForHotel() async {
  final network = Network('https://run.mocky.io/v3/8b4eaeb3-2e53-4286-995d-df11fc6fc28f');
  final networkData = await network.getData();
  return networkData;
}

Future<String> getNetworkDataForRoom() async {
  final network = Network('https://run.mocky.io/v3/7d6f62cc-7294-4606-818d-33402b2ae8dd');
  final networkData = await network.getData();
  return networkData;
}

Future<String> getNetworkDataFromReservation() async {
  final network = Network('https://run.mocky.io/v3/96cf7c34-472a-47e1-acca-2c4f007b48be');
  final networkData = await network.getData();
  return networkData;
}
