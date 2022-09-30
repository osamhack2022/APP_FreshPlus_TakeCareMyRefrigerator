import 'package:firebase_auth/firebase_auth.dart';
import 'login_form.dart';
import 'package:flutter/material.dart';
import '../general/homepage_logo.dart';
import 'package:get/get.dart';
import '../signup_page/signup_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LoginPage();
              } else {
                return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ListView(
                      children: [
                        HomepageLogo(),
                        const SizedBox(height: 24.0),
                        const Text(
                          "로그인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2C7B0C),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const LoginForm(),
                        Form(
                          key: _formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  
                                },
                                child: const Text(
                                  '비밀번호 재설정',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              const Text(
                                "|",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.to(SignupPage());
                                  }
                                },
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }
            }),
      ),
    );
  }
}
