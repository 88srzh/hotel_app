import 'package:flutter/material.dart';
import 'package:hotel_app/ui/widgets/Room/room_widget.dart';
import 'package:hotel_app/ui/widgets/hotel/hotel_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
        )
      ),
      // home: const HotelWidget(),
      home: const HotelWidget(),
    );
  }
}