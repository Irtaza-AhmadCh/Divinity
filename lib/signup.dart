import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/homescreen.dart';
import 'package:test_firebase/login.dart';
import 'errormassage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formkey = GlobalKey<FormState>();
  final Emailcontroller = TextEditingController();
  final Passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref('Users');

  @override
  void disposed() {
    super.dispose();

    Emailcontroller.dispose();
    Passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: false,
          title: const Text(
            'Signup Screen',
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
                          autofillHints: [AutofillHints.email],
                          validator: (Emailcontroller) =>
                              EmailValidator.validate(Emailcontroller!)
                                  ? null
                                  : 'Email is not valid',
                          controller: Emailcontroller,
                          decoration: InputDecoration(
                              hintText: 'Enter Email',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
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
                          'Enter Name ',
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (Passwordcontroller) =>
                            Passwordcontroller.toString()!.length >= 1
                                ? null
                                : 'Enter Name',
                        controller: namecontroller,
                        decoration: InputDecoration(
                            hintText: 'Enter Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (Passwordcontroller) =>
                            Passwordcontroller.toString()!.length >= 6
                                ? null
                                : 'Password atleast 6 character',
                        obscureText: true,
                        obscuringCharacter: '*',
                        autofillHints: [AutofillHints.password],
                        controller: Passwordcontroller,
                        decoration: InputDecoration(
                            hintText: 'Enter password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
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
                        setState(() {});
                        String Id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        _formkey.currentState!.validate()
                            ? (AddData(Id), _signup(), loader = false)
                            : null;
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: loader
                              ? showloading()
                              : Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext) => const LoginScreen()));
                        },
                        child: const Text(
                          'Have account? Login',
                          style: TextStyle(color: Colors.black),
                        )),
                    Text(
                      'Sign up With',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _google();
                            },
                            icon: Image.asset(
                              'assets/google.png',
                              scale: 18,
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  _signup() {
    _auth
        .createUserWithEmailAndPassword(
            email: Emailcontroller.text.toString(),
            password: Passwordcontroller.text.toString())
        .then((val) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext) => Homescreen()));
      loader = true;
      debugPrint('User Created');
    }).onError((error, stacktrace) {
      Errormassage.errormassage(context, error.toString());
      debugPrint(error.toString());
      loader = false;
    });
  }

  Widget showloading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 4,
        color: Colors.white,
      ),
    );
  }

  bool loader = false;

  _google() async {
    final GoogleSignIn signInAccount = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await signInAccount.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      Errormassage.errormassage(context, e.toString());
    }
  }

  AddData(Id) {
    databaseRef.child(Id).set({
      'Name': namecontroller.text,
      'Id': Id,
      'Email': Emailcontroller.text,
      'Password': Passwordcontroller.text,
    }).then((val) {
      Errormassage.errormassage(context, 'Data Added');
    }).onError((error, stackTrace) {
      Errormassage.errormassage(context, error.toString());
    });
  }
}
