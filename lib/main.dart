import 'package:e_commerce/admin/admin_login.dart';
import 'package:e_commerce/admin/home_admin_page.dart';
import 'package:e_commerce/pages/bottom_nav.dart';
import 'package:e_commerce/pages/forgot_password_page.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/login_page.dart';
import 'package:e_commerce/pages/onboard_page.dart';
import 'package:e_commerce/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: OnboardPage(),
    );
  }
}
