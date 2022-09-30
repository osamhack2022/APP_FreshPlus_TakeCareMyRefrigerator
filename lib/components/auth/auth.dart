import 'dart:async';
import 'package:flutter/material.dart';
import 'general/homepage_logo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'login_page/login_page.dart';

class Auth extends StatelessWidget {
  @override
  Auth({super.key}){
    timer = Timer(Duration(seconds:1),(){
      Get.to(LoginPage());
    });
  }
  late Timer timer;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: const AssetImage("assets/splash_background.jpg")),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 30.0),
                HomepageLogo(),
                const SizedBox(height: 221.0),
                const SpinKitFadingCircle(
                  color: Color(0xff2C7B0C),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
