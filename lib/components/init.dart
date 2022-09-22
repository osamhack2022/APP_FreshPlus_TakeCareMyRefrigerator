import 'package:firebase_core/firebase_core.dart';

Future initialize() async {
  FirebaseApp app = await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAbE1RD4DKZ6KGdA28v49m5B9vXF5FZ04M",
          authDomain: "armyhack-31975.firebaseapp.com",
          projectId: "armyhack-31975",
          storageBucket: "armyhack-31975.appspot.com",
          messagingSenderId: "413271187314",
          appId: "1:413271187314:web:4daa01923f5a6d76b147eb",
          measurementId: "G-0E807KXQ45"));
  print('Initialized default app $app');
}
