import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_the_hotel.freezed.dart';

@freezed
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AboutTheHotel with _$AboutTheHotel {
  factory AboutTheHotel({
    required String description,
    required String peculiarities,
  }) = _AboutTheHotel;

  factory AboutTheHotel.fromJson(Map<String, dynamic> json) => _$AboutTheHotelFromJson(json);
}
