import 'dart:developer';

import 'package:chat_application/models/users.dart';
import 'package:chat_application/views/screen/add_profile_screen.dart';
import 'package:chat_application/views/screen/auth/signup_screen.dart';
import 'package:chat_application/views/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/screen/auth/login_screen.dart';

class Auth extends GetxController {
  static Auth instance = Get.find();

  void Signup(String name, String email, String password) async {
    try {
      // null check
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // creating object of MyUser class
        MyUser myUser =
            MyUser(name: name, email: email, uid: userCredential.user!.uid);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set(myUser.toJson())
            .then((value) {
          Get.offAll(ProfileScreen());
        });
      } else {
        Get.snackbar('Error', 'Values can\'t be empty');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      Get.offAll(SignUp_Screen());
    }
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          if (FirebaseAuth.instance.currentUser!.uid != null) {
            Get.snackbar('Congratulation', "You have login successfully");
            Get.offAll(HomeScreen());
          }
        });
      } else {
        Get.snackbar(
            'Incomplete details', 'Please fill all the required fields');
      }
    } catch (e) {
      log(e.toString());
      Get.offAll(Login_Screen());
    }
  }
}
