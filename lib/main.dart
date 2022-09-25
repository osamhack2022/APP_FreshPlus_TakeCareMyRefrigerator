import 'package:firebase_auth/firebase_auth.dart';
import 'components/login_page_folder/custom_form.dart';
import 'components/login_page_folder/login_page.dart';
import 'package:flutter/material.dart';
import 'components/general/intro_splash.dart';
import 'firebase/init.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MaterialApp(
    home: IntroSplash(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Roboto"),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoginPage();
          } else {
            CustomForm();
          }
          return CustomForm();
        },
      ),
    );
  }
}