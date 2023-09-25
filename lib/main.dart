import 'package:chat_application/views/screen/add_profile_screen.dart';
import 'package:chat_application/views/screen/auth/login_screen.dart';
import 'package:chat_application/views/screen/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp_Screen(),
    );
  }
}
