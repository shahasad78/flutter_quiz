import 'package:flutter/material.dart';
import 'package:flutter_quiz/pages/landing_page.dart';


void main() {
  runApp(QuizApp());
}



class QuizApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

