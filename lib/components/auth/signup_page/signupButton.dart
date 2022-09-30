import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login_page/login_page.dart';

class SignupButton_page extends StatefulWidget {
  @override
  State<SignupButton_page> createState() => _SignupButtonState();
}

class _SignupButtonState extends State<SignupButton_page> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Color(0xff2C7B0C),
      onPrimary: Color(0xffE0E0E0),
    );

    return Center(
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          style: style,
          onPressed: () {
            Get.to(LoginPage());
          },
          child: Text("회원가입"),
        ),
      ),
    );
  }
}