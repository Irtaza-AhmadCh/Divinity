import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/signup.dart';
import 'homescreen.dart';


class SlpashServices{

 void logincheck(context) {
   final auth = FirebaseAuth.instance;
   final user = auth.currentUser;
   if(user == null ){
     Timer(Duration(seconds: 3),
         ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignScreen())));
   }
   else {
    Timer(Duration(seconds: 3),
        ()=>   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homescreen())));

   }
 }

}