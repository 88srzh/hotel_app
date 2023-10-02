import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_app/domain/api_client/network_client.dart';
import 'package:hotel_app/domain/entity/room.dart';

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
      body: ListView(
        children: const [],
      ),
    );
  }
}
