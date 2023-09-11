import 'package:equatable/equatable.dart';
import 'package:hotel_app/domain/entity/hotel.dart';

class HotelContainer extends Equatable {
  final List<Hotel> hotels;

  const HotelContainer.initial() : hotels = const <Hotel>[];

  const HotelContainer({
    required this.hotels,
  });

  @override
  List<Object> get props => [hotels];

  HotelContainer copyWith({
    List<Hotel>? hotels,
  }) {
    return HotelContainer(
      hotels: hotels ?? this.hotels,
    );
  }
}
