

import 'package:hotel_app/domain/api_client/hotel_api_client.dart';

part 'hotel_bloc.freezed.dart';

part 'hotel_event.dart';

part 'hotel_state';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final _apiClient = HotelApiClient();
}