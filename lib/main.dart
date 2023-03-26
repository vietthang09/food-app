import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD6VOffFcqOrm18dFnmFEFPm8GO-bTd5Fo",
          appId: "1:225954428943:web:6acf893cb0bd89e28d4b7a",
          messagingSenderId: "225954428943",
          projectId: "food-app-eba83"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignIn());
  }
}
