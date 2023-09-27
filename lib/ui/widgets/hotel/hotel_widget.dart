import 'package:flutter/material.dart';
import 'package:hotel_app/domain/api_client/new_network_client.dart';
import 'package:hotel_app/domain/entity/hotel.dart';
import 'package:hotel_app/ui/widgets/hotel/components/about_hotel_widget.dart';
import 'package:hotel_app/ui/widgets/hotel/components/photo_carousel_widget.dart';
import 'package:hotel_app/ui/widgets/hotel/components/selection_button_widget.dart';
import 'package:http/http.dart' as http;

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
      body: FutureBuilder<List<Hotel>>(
        future: fetchData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return HotelWidgetBody(hotels: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class HotelWidgetBody extends StatelessWidget {
  const HotelWidgetBody({super.key, required this.hotels});

  final List<Hotel> hotels;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoCarouselWidget(hotels: hotels),
            const AboutHotelWidget(),
            const SelectionButtonWidget(),
          ],
        ),
      ],
    );
  }
}

