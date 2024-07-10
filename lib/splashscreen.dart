import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/signup.dart';
import 'package:test_firebase/splashservices.dart';

import 'homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  SlpashServices splash  = SlpashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
splash.logincheck(context);

        }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Text(
        'Test Firebase',
        style: TextStyle(
          fontSize: 30,
        ),
      )),
    );
  }
}
