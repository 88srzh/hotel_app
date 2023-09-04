import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';
import 'package:hotel_app/ui/components/LoadingIndicatorWidget.dart';

class PhotoCarouselWidget extends StatefulWidget {
  const PhotoCarouselWidget({super.key});

  @override
  State<PhotoCarouselWidget> createState() => _PhotoCarouselWidgetState();
}

class _PhotoCarouselWidgetState extends State<PhotoCarouselWidget> {
  int _currentPhoto = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    // final posterPath = Configuration.imageUrls[index];
                    return Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: CachedNetworkImage(
                        imageUrl: 'https://www.gstatic.com/webp/gallery3/1.sm.png',
                        placeholder: (context, url) => const LoadingIndicatorWidget(),
                        errorWidget: (context, url, dynamic error) => Image.asset(AppImages.noImage),
                      ),
                    );
                  },
                ),
              ),
              // Positioned(
              //   left: 50,
              //   top: 40,
              //   right: 50,
              //   bottom: 10,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         List.generate(
              //           20,
              //           (index) => buildDot(index: index),
              //           growable: false,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.orangeText,
              ),
              Text(
                'rating',
                style: TextStyle(
                  color: AppColors.orangeText,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                'rating_name',
                style: TextStyle(
                  color: AppColors.orangeText,
                ),
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
          const Text(
            'adress',
            style: TextStyle(
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
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5.0),
      height: 6,
      width: _currentPhoto == index ? 20 : 6,
      decoration: BoxDecoration(
        // refactoring color
        color: _currentPhoto == index ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
