import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/homescreen.dart';
import 'package:test_firebase/navigator.dart';
import 'package:test_firebase/phonesignup.dart';
import 'package:test_firebase/signup.dart';

import 'errormassage.dart';
import 'forgetpassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  final _auth = FirebaseAuth.instance;

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroler.text,
            password: passwordcontroler.text.toString())
        .then((val) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Homescreen()));
    }).onError((error, stacktrace) {
      Errormassage.errormassage( context, error.toString());

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Login Screen',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Email ',
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator:(emailcontroler) =>
                          (EmailValidator.validate(emailcontroler!)? null : 'Invalid Email '
                          ),
                          controller: emailcontroler,
                          decoration: InputDecoration(
                              hintText: 'Enter Email',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Password ',
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        autofillHints: const [AutofillHints.password],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (passwordcontroller) =>
                        passwordcontroller.toString().length >= 6?
                                null: 'Password atleast 6 character'
                        ,
                        controller: passwordcontroler,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:const  BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        _formkey.currentState!.validate() ?
                        {
                          login()}: null;
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
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [ TextButton(
                          onPressed: () {
                            NavigatorTo.navigator(context, Forgetpassword());
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        SizedBox(width: 55,)
                      ]
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignScreen()));
                        },
                        child: const Text(
                          'No account? Signup',
                          style: TextStyle(color: Colors.black),
                        )),

                    ElevatedButton(onPressed: (){
                      NavigatorTo.navigator(context, phoneverify());
                    }, child: Text(
                      'Phone Number Verifycation', style: TextStyle(
                        color: Colors.blue
                    ),
                    ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
