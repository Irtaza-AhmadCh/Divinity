import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/login.dart';
import 'package:test_firebase/navigator.dart';
import 'package:test_firebase/profile.dart';
import 'errormassage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final auth = FirebaseAuth.instance;
  final _ref = FirebaseDatabase.instance.ref('Users');
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
          'Home Screen',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(Icons.login, color: Colors.white, size: 30)),
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
              child: StreamBuilder(
                  stream: _ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();
                      final user = auth.currentUser;



                      var count = list.length;
                      ;
                      return ListView.builder(
                          itemCount: count,
                          itemBuilder: (context, index) {
                            if (_searchController.text.isEmpty) {
                              return _contentStream(list: list, index: index);
                            } else if (list[index]['Name']
                                .toString()
                                .toLowerCase()
                                .contains(
                                    _searchController.text.toLowerCase())) {
                              return _contentStream(list: list, index: index);
                            } else {
                              return const Center(
                                  child: Text(
                                'No Data Found',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              ));
                            }
                          });
                    }
                    else {
                      return const Text('No Data');
                    }
                  })),


          const Text(
            'FirebaseAnimation',
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: _ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: 330,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Id : ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    snapshot.child('Id').value.toString(),
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
                                  snapshot.child('Email').value.toString(),
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
                                  snapshot.child('Name').value.toString(),
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
                                  snapshot.child('Password').value.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),

        onPressed: (){
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

  Widget _contentStream({list, index}) {
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
                          UpdataDialog(List: list, Index: index);
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
                          _ref.child(list[index]['Id'].toString()).remove();
                          setState(() {});
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
                list[index]['Id'],
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
                  list[index]['Email'],
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
                  list[index]['Name'],
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
                  list[index]['Password'],
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  UpdataDialog({List, Index, Name}) {
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
                      _ref.child(List[Index]['Id']).update({
                        'Name': NameController.text,
                        'Email': EmailController.text
                      }).then((val) {
                        Errormassage.errormassage(context, 'Updated');
                        Navigatorpop;
                      }).onError((error, stackTrace) {
                        Errormassage.errormassage(context, error);
                      });
                      Navigator.pop(context);
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
}
