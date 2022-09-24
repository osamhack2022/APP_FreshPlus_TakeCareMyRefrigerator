import 'dart:async';
import 'package:flutter/material.dart';
import '../homepage_logo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'login_page.dart';

class IntroSplash extends StatefulWidget {
  const IntroSplash({Key? key}) : super(key: key);
  _IntroSplashState createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage("assets/splash_background.jpg")),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 30.0),
                HomepageLogo(),
                SizedBox(height: 221.0),
                const SpinKitFadingCircle(
                  color: Color(0xff2C7B0C),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName("/login"));
  }
}
