import 'components/auth/auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'firebase/init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialize();
  runApp( GetMaterialApp(
    home: Auth(),
  ));
}
