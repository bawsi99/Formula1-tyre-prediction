import 'package:f1_models_web/locator.dart';
import 'package:f1_models_web/main_screens/home_screen.dart';
import 'package:f1_models_web/main_screens/layout_template/layout_template.dart';
import 'package:flutter/material.dart';
import 'config/palette.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0x00ff1801);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F1-VRSE',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LayoutTemplate(),
    );
  }
}
