import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:test_firebase/navigator.dart';
import 'package:test_firebase/verifycode.dart';

import 'errormassage.dart';

class phoneverify extends StatefulWidget {
  const phoneverify({super.key});

  @override
  State<phoneverify> createState() => _phoneverifyState();
}

class _phoneverifyState extends State<phoneverify> {

  final auth = FirebaseAuth.instance;
  var phoneNo;
  TextEditingController PhoneNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey,
            title: const Text(
              ' Phone Verification',
              style: TextStyle(color: Colors.white, fontSize: 30),
            )),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //   child: SizedBox(
          //     width: 300,
          //     child: TextFormField(
          //       autofillHints: [AutofillHints.email],
          //      keyboardType: TextInputType.phone,
          //       // validator: (PhoneNoController) =>
          //       // EmailValidator.validate(PhoneNoController!)? null: 'Email is not valid' ,
          //       controller: PhoneNoController,
          //       decoration: InputDecoration(
          //           hintText: 'Enter Phone No.',
          //           border: OutlineInputBorder(
          //             borderSide: const BorderSide(color: Colors.black, width: 2),
          //             borderRadius: BorderRadius.circular(25),
          //           )),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: IntlPhoneField(
              decoration: InputDecoration(
                  hintText: 'Enter Phone No.',
                   border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  )),
              onChanged: (phone){
                 phoneNo = phone.completeNumber;
              },
            ),
          ),
          const SizedBox(height: 40,),
          InkWell(
            onTap: () {
              print(phoneNo);
              verify();
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
                  'Verify Phone No',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  verify(){
     auth.verifyPhoneNumber(
       phoneNumber: phoneNo,
         verificationCompleted: (_){},
         verificationFailed: (e){
           Errormassage.errormassage(context , e);

         },
         codeSent: (String VerId , int? token){
         NavigatorTo.navigator(context, Verifycode(VerId: VerId));

         },

         codeAutoRetrievalTimeout:  (e){
    Errormassage.errormassage(context , e.toString());

    },
     );
  }
}
