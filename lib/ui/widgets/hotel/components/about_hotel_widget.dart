import 'package:flutter/material.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';
import 'package:hotel_app/ui/widgets/hotel/components/custom_divider.dart';
import 'package:hotel_app/ui/widgets/hotel/components/custom_listtile.dart';

class AboutHotelWidget extends StatelessWidget {
  const AboutHotelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // var cubit = context.watch<HotelCubit>();
    // final String description = cubit.state.hotels[index].aboutTheHotel.description;
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
          CustomListTile(leadingImage: AppImages.emojiHappy, firstText: 'Удобства'),
          CustomDivider(),
          CustomListTile(leadingImage: AppImages.tickSquare, firstText: 'Что включено'),
          CustomDivider(),
          CustomListTile(leadingImage: AppImages.closeSquare, firstText: 'Что не включено'),
        ],
      ),
    );
  }
}
