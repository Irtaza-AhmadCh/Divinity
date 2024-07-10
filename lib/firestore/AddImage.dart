import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_firebase/firestore/FreStoreSignUp.dart';
import 'package:test_firebase/login.dart';
import 'package:test_firebase/navigator.dart';
import 'package:test_firebase/profile.dart';
import '../errormassage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {

  firebase_storage.FirebaseStorage storeImage = firebase_storage.FirebaseStorage.instance;




   File? _image;
   final   _picker = ImagePicker();

 Future getImage(source) async {
   final _pickedImage = await _picker.pickImage(source: source);
setState(() {
  if( _pickedImage != null ){
    _image = File(_pickedImage.path);
  }
  else{
    print('No Image Picker');
  }
});

 }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Add Image Screen',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Container(
    height: 300,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.grey.shade300,
    ),
      child: (_image== null)? Icon(Icons.person, size: 200,  color: Colors.grey.shade700,):
      Image.file(_image!),
    ),
      SizedBox(height: 50,),
      Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send ,color: Colors.white,),
            SizedBox(width: 5,),
            Text('Send' , style: TextStyle(

                color: Colors.white
            ),)
          ],
        ),
      ),
      SizedBox(height: 20,),
      InkWell(
        onTap: (){
          getImage(ImageSource.camera);
          print('Tap');
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo ,color: Colors.white,),
              SizedBox(width: 5,),
              Text('Camera' , style: TextStyle(

                  color: Colors.white
              ),)
            ],
          ),
        ),
      ),
      SizedBox(height: 20,),
      InkWell(
        onTap: (){
          getImage(ImageSource.gallery);
        } ,
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo ,color: Colors.white,),
              SizedBox(width: 5,),
              Text('Gallary' , style: TextStyle(

                  color: Colors.white
              ),)
            ],
          ),
        ),
      )
    ],
  ),
),
    );

  }


}
