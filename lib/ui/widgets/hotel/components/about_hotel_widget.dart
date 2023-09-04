import 'package:flutter/material.dart';

class AboutHotelWidget extends StatelessWidget {
  const AboutHotelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(16.0),
      child: Column(
        children: [
          Text(
            'Об отеле',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '3-я линия',
            style: TextStyle(

            ),
          ),

        ],
      ),
    );
  }
}
