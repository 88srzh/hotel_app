import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel_app/domain/entity/about_the_hotel.dart';
import 'package:hotel_app/ui/widgets/hotel/components/hotel_data.dart';

part 'hotel.freezed.dart';

@freezed
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Hotel with _$Hotel {
  factory Hotel({
    required int id,
    required String name,
    required String adress,
    required int minimalPrice,
    required String priceForIt,
    required int rating,
    required String ratingName,
    required List<String> imageUrls,
    required AboutTheHotel aboutTheHotel,
  }) = _Hotel;

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
}

