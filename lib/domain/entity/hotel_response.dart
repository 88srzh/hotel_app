import 'package:hotel_app/domain/entity/hotel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HotelResponse {
  List<Hotel> hotel;

  HotelResponse({
    required this.hotel,
  });

  factory HotelResponse.fromJson(Map<String, dynamic> json) => _$HotelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotelResponseToJson(this);
}