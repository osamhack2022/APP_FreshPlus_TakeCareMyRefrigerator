import 'package:flutter/material.dart';
import 'components/init.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
//import '/home_page/master/master_page/m_page.dart'
import 'package:helloworld/components/home_page/master/master_page/m_page.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(GetMaterialApp(
    home: MPage(),
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
    return Scaffold();
  }
}
