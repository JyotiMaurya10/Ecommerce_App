// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/get_user_data_controller.dart';
import '../../utils/app_constant.dart';
import '../admin-panel/admin_panel.dart';
import '../user-panel/main_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      loggdin(context);
    });
  }

  Future<void> loggdin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => AdminMainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.appSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Container(
              // width: Get.width,
              width: 300,
              height: 300,
              alignment: Alignment.center,
              child: Lottie.asset('assets/images/splash_screen.json'),
            ),
            //      SizedBox(
            //   height: 120,
            //   child: OverflowBox(
            //     minHeight: 300,
            //     maxHeight: 300,
            //     child: Lottie.asset(
            //       'assets/images/splash_screen.json',
            //       repeat: false,
            //     ),
            //   ),
            // )
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: Get.width,
            alignment: Alignment.center,
            child: Text(
              AppConstant.appPoweredBy,
              style: TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
