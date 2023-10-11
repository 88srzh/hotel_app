import 'package:flutter/material.dart';
import 'package:hotel_app/resources/app_colors.dart';

class FiveStarRowWidget extends StatelessWidget {
  const FiveStarRowWidget({
    super.key,
    required this.hotel,
  });

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29.0,
      width: 153.0,
      decoration: const BoxDecoration(
        color: AppColors.orangeBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: [
            const Icon(Icons.star, color: AppColors.orangeText, size: 15),
            Text(
              hotel.rating.toString(),
              style: const TextStyle(color: AppColors.orangeText, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5.0),
            Text(
              hotel.ratingName,
              style: const TextStyle(color: AppColors.orangeText, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
