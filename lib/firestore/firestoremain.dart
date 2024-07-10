
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/firestore/FreStoreSignUp.dart';
import 'package:test_firebase/login.dart';
import 'package:test_firebase/navigator.dart';
import 'package:test_firebase/profile.dart';
import '../errormassage.dart';
import 'AddImage.dart';

class FireStoreHomescreen extends StatefulWidget {
  const FireStoreHomescreen({super.key});

  @override
  State<FireStoreHomescreen> createState() => _FireStoreHomescreenState();
}

class _FireStoreHomescreenState extends State<FireStoreHomescreen> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('User').snapshots();
  final _collectionRef = FirebaseFirestore.instance.collection('User');

  TextEditingController _searchController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController NameController = TextEditingController();

  @override
  void disposed() {
    super.dispose();

    EmailController.dispose();
    NameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'FireStore Home Screen',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigatorTo.navigator(context, FirestoreSignScreen());
              },
              icon: const Icon(Icons.login, color: Colors.white, size: 30)),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                NavigatorTo.navigator(context, AddImageScreen());
              },
              icon: const Icon(Icons.add_a_photo, color: Colors.white, size: 30)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              onChanged: (String search) {
                setState(() {});
              },
            ),
          ),

          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: fireStore,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator( color: Colors.blueGrey,
                        ),
                      );
                    } else if(snapshot.hasError) {
                      return Text('Error occur');

                    } else{

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                              return
                                _contentStream( snapshot: snapshot, index: index);

                          });
                  }
                  }
                    )
    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),
        onPressed: () {
          // NavigatorTo.navigator(context, ProfileScreen());
        },
      ),
    );
  }

  _logout(context) {
    auth.signOut().then((val) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext) => const LoginScreen()));
    }).onError((error, stackTreace) {
      Errormassage.errormassage(context, error.toString());
    });
  }

  Widget _contentStream({required AsyncSnapshot<QuerySnapshot> snapshot, index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Container(
            height: 200,
            width: 330,
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            onTap: () {
                              Navigatorpop;
                              UpdataDialog( snapshot , index);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.edit),
                                Text('Updated'),
                              ],
                            )),
                        PopupMenuItem(
                            onTap: () {
                              Navigatorpop;

                              setState(() {
                                Delete(snapshot, index);
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.delete),
                                Text('Delete'),
                              ],
                            )),
                      ];
                    })
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'Id : ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    snapshot.data!.docs[index]['Id'].toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Email : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                        snapshot.data!.docs[index]['Email'].toString() ,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Name : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      snapshot.data!.docs[index]['Name'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Password : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      snapshot.data!.docs[index]['Password'].toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  UpdataDialog( AsyncSnapshot<QuerySnapshot> snapshot, index){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('UpDate Content')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: NameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter New Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: EmailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter New Email',
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _collectionRef.doc(snapshot.data!.docs[index]['Id'].toString()).update(
                        {
                          'Email' : EmailController.text,
                          'Name' : NameController.text,
                        }
                      ).then((val){
                       void dispose(){
                         super.dispose;
                         EmailController.dispose();
                         NameController.dispose();
                       }
                      }).onError((error,stackTrace){
                        Errormassage.errormassage(context, error);
                      });
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          );
        });
  }

Delete( AsyncSnapshot<QuerySnapshot> snapshot, index){
 ( _collectionRef.doc(snapshot.data!.docs[index]['Id'].toString())).delete();
}


}
