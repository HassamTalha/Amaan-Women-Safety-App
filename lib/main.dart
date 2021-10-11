import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:womensafteyhackfair/Dashboard/Splsah/Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hackfair 2.0 - GDSC - CUI',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}
