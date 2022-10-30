import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/addblog_screen.dart';
import 'package:fireblogs/screens/option_screen.dart';
import 'package:fireblogs/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final firecollection =
      FirebaseFirestore.instance.collection('Blogs').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backwardsCompatibility: false,
        title: Text('All Blogs'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddBlogScreen()));
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
              icon: Icon(Icons.account_box)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: firecollection,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Internal Server Error'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          //color: Colors.teal
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Image(
                                height: 100,
                                width: double.infinity,
                                image: NetworkImage(snapshot.data!.docs[index]["imgUrl"]),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                snapshot.data!.docs[index]["title"],
                                style: TextStyle(
                                    color: Colors.blue.shade800, fontSize: 19),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.docs[index]["desc"],
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]["time"],
                                    style: TextStyle(
                                        color: Colors.teal, fontSize: 13),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]["name"],
                                    style: TextStyle(
                                        color: Colors.teal, fontSize: 13),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.blue,
      fontSize: 16.0,
    );
  }
}
