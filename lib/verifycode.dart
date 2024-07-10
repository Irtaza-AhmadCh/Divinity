import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/errormassage.dart';
import 'package:test_firebase/homescreen.dart';
import 'package:test_firebase/navigator.dart';

class Verifycode extends StatefulWidget {
  final VerId;
  const Verifycode({super.key, this.VerId});

  @override
  State<Verifycode> createState() => _VerifycodeState();
}

class _VerifycodeState extends State<Verifycode> {
   TextEditingController VerificationCodeController = TextEditingController();
   final _formkey = GlobalKey<FormState>();
   final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
      automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
          title: const Text(
            '  Verification Code',
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.phone,
                validator:  (VerificationCodeController) =>
                VerificationCodeController.toString()!.length >= 6 ?
                null: 'Enter 6 digit otp',
                  controller: VerificationCodeController,
                  decoration: InputDecoration(
                      hintText: 'Enter Verification code',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            InkWell(
              onTap: ()async {

                    final credential = PhoneAuthProvider.credential(
                    verificationId: widget.VerId,
                    smsCode: VerificationCodeController.text.toString());

                try{

                  await auth.signInWithCredential(credential).then((val){
                    NavigatorTo.navigator(context, Homescreen());
                  }).onError((error, stackTrace){
                    Errormassage.errormassage(context, error.toString());
                  });

                }catch(error){
                  Errormassage.errormassage(context, error.toString());
                }
              },


              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black)),
                child:  const Center(
                  child: Text(
                    'Verify',
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
}

