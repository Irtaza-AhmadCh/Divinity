import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/homescreen.dart';
import 'package:test_firebase/splashscreen.dart';
import 'package:test_firebase/verifycode.dart';
import 'firestore/AddImage.dart';
import 'firestore/FreStoreSignUp.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyAqhHSNT-wG3cVyrhQOG6um1LtshNZSEaY',
        appId: '1:744135569760:android:6a6e181f2d31aaaba0ae05',
        messagingSenderId: '113372571859',
        projectId:'fir-learn-ebc84')
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: const AddImageScreen(),
    );

  }
}

