import 'package:flutter/material.dart';
import 'package:hotel_app/ui/widgets/hotel/components/about_hotel_widget.dart';
import 'package:hotel_app/ui/widgets/hotel/components/photo_carousel_widget.dart';

class HotelWidget extends StatefulWidget {
  const HotelWidget({super.key});

  @override
  State<HotelWidget> createState() => _HotelWidgetState();
}

class _HotelWidgetState extends State<HotelWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Отель',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhotoCarouselWidget(),
          AboutHotelWidget(),
        ],
      ),
    );
  }
}

