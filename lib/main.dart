import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufsmachinetest/controller/bottom_sheet_controller.dart';
import 'package:ufsmachinetest/controller/home_screen_controller.dart';
import 'package:ufsmachinetest/controller/productscreen_controller.dart';
import 'package:ufsmachinetest/view/homescreen/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomSheetController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductscreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
      ),
    );
  }
}
