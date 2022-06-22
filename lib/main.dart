// @dart=2.9
import 'package:flutter/material.dart';

import 'home_page.dart';

const proxy = 'https://cors-anywhere.herokuapp.com/';
const urlAPI = 'https://aqueous-anchorage-93443.herokuapp.com/FixMyEnglish';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  final MaterialColor kPrimaryColor = const MaterialColor(
    0xFF494507,
    const <int, Color>{
      50: const Color(0xFF494507),
      100: const Color(0xFF494507),
      200: const Color(0xFF494507),
      300: const Color(0xFF494507),
      400: const Color(0xFF494507),
      500: const Color(0xFF494507),
      600: const Color(0xFF494507),
      700: const Color(0xFF494507),
      800: const Color(0xFF494507),
      900: const Color(0xFF494507),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fix My English',
      home: HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kPrimaryColor,
        )
      ),
    );
  }
}
