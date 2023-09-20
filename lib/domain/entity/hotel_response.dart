import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel_app/domain/entity/hotel.dart';

part 'hotel_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HotelResponse {
  final List<Hotel> hotel;

  HotelResponse({required this.hotel});

  factory HotelResponse.fromJson(Map<String, dynamic> json) => _$HotelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotelResponseToJson(this);
}