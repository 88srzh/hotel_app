// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      id: json['id'] as int,
      name: json['name'] as String,
      adress: json['adress'] as String,
      minimalPrice: json['minimal_price'] as int,
      priceForIt: json['price_for_it'] as String,
      rating: json['rating'] as int,
      ratingName: json['rating_name'] as String,
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adress': instance.adress,
      'minimal_price': instance.minimalPrice,
      'price_for_it': instance.priceForIt,
      'rating': instance.rating,
      'rating_name': instance.ratingName,
    };
