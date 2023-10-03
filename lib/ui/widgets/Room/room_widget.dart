import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/domain/api_client/network_client.dart';
import 'package:hotel_app/domain/entity/room.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';
import 'package:hotel_app/ui/components/LoadingIndicatorWidget.dart';

class RoomWidget extends StatefulWidget {
  const RoomWidget({super.key});

  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  var roomList = const Rooms(rooms: []);

  void getRoomData() async {
    final roomListJson = await getNetworkDataForRoom();
    // print(roomListJson);
    final dynamic roomListMap = json.decode(roomListJson);

    setState(() {
      roomList = Rooms.fromJson(roomListMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getRoomData();
  }

  int _currentPhoto = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Steigenberger Makadi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: ListView.builder(
          itemCount: roomList.rooms.length,
          itemBuilder: (context, index) {
            var peculiarities = makeRoomPeculiarities(roomList, index);
            return Column(
              children: [
                const SizedBox(height: 5.0),
                Container(
                  height: 539,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 257,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: PageView.builder(
                                onPageChanged: (value) {
                                  setState(() {
                                    _currentPhoto = value;
                                  });
                                },
                                itemCount: roomList.rooms.length,
                                itemBuilder: (context, index) {
                                  final image = roomList.rooms[index].imageUrls[index];
                                  return Container(
                                    // TODO image not round
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    // TODO добавить проверку на корректность ссылки
                                    child: CachedNetworkImage(
                                      imageUrl: image,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              roomList.rooms[index].name,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              peculiarities,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyText,
                                backgroundColor: AppColors.greyBackgroundText,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              width: 202.0,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: AppColors.roomDetailsBackgroundColor,
                              ),
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 2.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Подробнее о номере',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.roomDetailsTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: AppColors.roomDetailsTextColor, size: 24),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // TODO refactor to separate file
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

  String makeRoomPeculiarities(Rooms roomList, int index) {
    var texts = <String>[];
    if (roomList.rooms.isNotEmpty) {
      var names = <String>[];
      for (var name in roomList.rooms[index].peculiarities) {
        names.add(name.characters.string);
      }
      texts.add(names.join('     '));
    }
    return texts.join(' ');
  }
}
