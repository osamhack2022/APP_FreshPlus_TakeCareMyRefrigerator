import 'package:firebase_core/firebase_core.dart';

Future<void> initialize() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCb7dzWlfrFOELNCYKaYwVQm-APYtNt3ws",
          authDomain: "fresh-plus-osam.firebaseapp.com",
          projectId: "fresh-plus-osam",
          storageBucket: "fresh-plus-osam.appspot.com",
          messagingSenderId: "160603413044",
          appId: "1:160603413044:web:557439427153a6a8928861",
          measurementId: "G-7VLH0B8XT1"));
}
