import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/errormassage.dart';
import 'package:test_firebase/login.dart';
import 'package:test_firebase/navigator.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {

  final auth = FirebaseAuth.instance;
  TextEditingController forgotController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
          title: const Text(
            '   Forget Password',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )),

      body: Form(
      key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: forgotController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.phone,
                  validator: (forgotController) =>
EmailValidator.validate(forgotController!) ?
                  null : 'Enter valid email',
                  decoration: InputDecoration(
                      hintText: 'Enter Email ',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            InkWell(
              onTap: () {
                _formkey.currentState!.validate()?
                   _forgotPassword(forgotController.text.toString()):  print('n');
              },


              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black)),
                child: const Center(
                  child: Text(
                    'Resend',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _forgotPassword(String email){

    auth.sendPasswordResetEmail(email: email).then((val){
      NavigatorMove.navigator(context, LoginScreen());
      Errormassage.errormassage(context, 'Email sent');
    }).onError((error, stackTrace){
      Errormassage.errormassage(context, error.toString());

    });

  }
}
