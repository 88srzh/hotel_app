import 'package:flutter/material.dart';
import 'package:hotel_app/resources/app_colors.dart';

class AboutHotelWidget extends StatelessWidget {
  const AboutHotelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Об отеле',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'about_the_hotel.peculiarities',
            style: TextStyle(
              backgroundColor: AppColors.greyBackgroundText,
            ),
          ),
          Text(
            'about_the_hotel.description',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.0),
          ListTile(
            title: Text(
              'Удобства',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Самое необходимое',
              style: TextStyle(color: AppColors.greyText, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
