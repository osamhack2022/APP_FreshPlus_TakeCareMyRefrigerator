import 'components/auth/auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'firebase/init.dart';

// import 'firebase/controller/auth/sign_in_ctrl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialize();
  // print(await signIn("test.io","testtest"));
  runApp(GetMaterialApp(
    home: Auth(),
  ));
}