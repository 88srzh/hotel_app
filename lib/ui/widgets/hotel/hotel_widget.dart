import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/domain/api_client/network_client.dart';
import 'package:hotel_app/domain/entity/about_the_hotel.dart';
import 'package:hotel_app/domain/entity/hotel.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';
import 'package:hotel_app/ui/components/LoadingIndicatorWidget.dart';
import 'package:hotel_app/ui/widgets/hotel/components/about_hotel_widget.dart';
import 'package:hotel_app/ui/widgets/hotel/components/selection_button_widget.dart';

class HotelWidget extends StatefulWidget {
  const HotelWidget({super.key});

  @override
  State<HotelWidget> createState() => _HotelWidgetState();
}

class _HotelWidgetState extends State<HotelWidget> {
  var hotel = Hotel(
    id: 0,
    name: '',
    adress: '',
    minimalPrice: 0,
    priceForIt: '',
    rating: 0,
    ratingName: '',
    imageUrls: [],
    aboutTheHotel: AboutTheHotel(description: '', peculiarities: []),
  );

  void getHotelData() async {
    final hotelJson = await getNetworkData();
    // print(hotelJson);
    final dynamic hotelMap = json.decode(hotelJson);

    setState(() {
      hotel = Hotel.fromJson(hotelMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getHotelData();
  }

  int _currentPhoto = 0;

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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 530.0,
                width: 375.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 257,
                            width: 343,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: PageView.builder(
                              onPageChanged: (value) {
                                setState(() {
                                  _currentPhoto = value;
                                });
                              },
                              // TODO change item count
                              itemCount: hotel.imageUrls.length,
                              itemBuilder: (BuildContext context, int index) {
                                final image = hotel.imageUrls[index];
                                return Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    placeholder: (context, url) => const LoadingIndicatorWidget(),
                                    errorWidget: (context, url, dynamic error) => Image.asset(AppImages.noImage),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: 50,
                            top: 40,
                            right: 50,
                            bottom: 10,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => buildDot(index: index),
                                  growable: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.orangeText),
                          Text(
                            // widget.hotels[index].rating.toString(),
                            hotel.rating.toString(),
                            style: const TextStyle(color: AppColors.orangeText),
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            hotel.ratingName,
                            style: const TextStyle(color: AppColors.orangeText),
                          ),
                        ],
                      ),
                      const Text(
                        'Steigenberger Makadi',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        hotel.adress,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.blueText,
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            'от 000 000 ₽',
                            style: TextStyle(
                              textBaseline: TextBaseline.ideographic,
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'за тур с перелётом',
                            style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const AboutHotelWidget(),
              const SelectionButtonWidget(),
            ],
          ),
        ],
      ),
      // body: FutureBuilder<List<Hotel>>(
      //   future: getNetworkData(http.Client()),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text('${snapshot.error}'),
      //       );
      //     } else if (snapshot.hasData) {
      //       return HotelWidgetBody(hotels: snapshot.data!);
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5.0),
      height: 6,
      width: _currentPhoto == index ? 10 : 6,
      decoration: BoxDecoration(
        // refactoring color
        color: _currentPhoto == index ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
