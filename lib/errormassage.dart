import 'package:flutter/material.dart';

class Errormassage {

 static  void errormassage( context, error){
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: Text('$error'),
     backgroundColor: Colors.blue,
   ));
 }

}