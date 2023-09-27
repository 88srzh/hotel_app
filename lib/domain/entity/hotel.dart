import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel_app/domain/entity/about_the_hotel.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Hotel {
  final int id;
  final String name;
  final String adress;
  final int minimalPrice;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final List<String> imageUrls;
  final AboutTheHotel aboutTheHotel;

  const Hotel({
    required this.id,
    required this.name,
    required this.adress,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.imageUrls,
    required this.aboutTheHotel,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] as int,
      name: json['name'] as String,
      adress: json['adress'] as String,
      minimalPrice: json['minimalPrice'] as int,
      priceForIt: json['priceForIt'] as String,
      rating: json['rating'] as int,
      ratingName: json['ratingName'] as String,
      imageUrls: json['imageUrls'] as List<String>,
      aboutTheHotel: json['aboutTheHotel'] as AboutTheHotel,
    );
  }
}
