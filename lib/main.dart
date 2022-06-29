// @dart=2.9
import 'package:FixMyEnglish/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

const proxy = 'https://cors-anywhere.herokuapp.com/';
const urlAPI = 'https://aqueous-anchorage-93443.herokuapp.com/FixMyEnglish';

FirebaseApp fbApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  fbApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  final MaterialColor kPrimaryColor = const MaterialColor(
    0xFF494507,
    <int, Color>{
      50: Color(0xFF494507),
      100: Color(0xFF494507),
      200: Color(0xFF494507),
      300: Color(0xFF494507),
      400: Color(0xFF494507),
      500: Color(0xFF494507),
      600: Color(0xFF494507),
      700: Color(0xFF494507),
      800: Color(0xFF494507),
      900: Color(0xFF494507),
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
        ),
      ),
    );
  }
}
