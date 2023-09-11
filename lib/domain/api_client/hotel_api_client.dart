import 'package:hotel_app/domain/api_client/network_client.dart';
import 'package:hotel_app/domain/entity/hotel_response.dart';

class HotelApiClient {
  final _networkClient = NetworkClient();

  Future<HotelResponse> hotel(
    String apiKey,
  ) async {
    HotelResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = HotelResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
      },
    );
    return result;
  }
}
