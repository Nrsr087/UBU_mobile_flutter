import 'package:flutter/material.dart';
import 'package:ubuapp/mockup/data.dart';
import 'package:ubuapp/onboarding_screen.dart';
import 'package:ubuapp/pages/Login.dart';
import 'package:ubuapp/pages/coursedetailpage.dart';
import 'package:ubuapp/pages/myhomepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UBU APP',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/Login': (context) => Login(),
        '/HomeView': (context) => const HomeView(),
        '/detail': (context) => CourseDetailPage(course: randomCourse()),
      },
    );
  }
}