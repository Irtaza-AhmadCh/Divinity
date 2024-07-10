import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add_Post extends StatefulWidget {
  const Add_Post({super.key});

  @override
  State<Add_Post> createState() => _Add_PostState();
}

class _Add_PostState extends State<Add_Post> {

  TextEditingController Addcontroller = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Paost');

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
                          'Add Post ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        maxLines: 5,
                        autofillHints: const [AutofillHints.password],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: Addcontroller,
                        decoration: InputDecoration(
                            hintText: 'What is in your mind',
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
                        databaseRef.child('1').set({
                          'id' : 1
                        });
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
                            'Add',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),

                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
