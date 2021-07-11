import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splashScreen.dart';

void main() => runApp(TourMendApp());

class TourMendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'TourMend',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.lightBlue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText2: GoogleFonts.montserrat(textStyle: textTheme.bodyText2),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
