import 'package:flutter/material.dart';
import 'package:hotel_app/resources/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // TODO fix width, need more
        width: 275,
        height: 1,
        color: AppColors.dividerColor,
      ),
    );
  }
}
