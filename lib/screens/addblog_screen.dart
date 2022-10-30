import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireblogs/components/button.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({Key? key}) : super(key: key);

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final firestore = FirebaseFirestore.instance.collection('Blogs');

  Reference referenceRoot = FirebaseStorage.instance.ref();

  final imagePicker = ImagePicker();
  File? image;

  String imgUrl = "";

  final _formkey = GlobalKey<FormState>();

  String title = "";
  String desc = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  return value!.isEmpty ? 'Enter blog title' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter blog title',
                    labelText: 'Title',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descController,
                validator: (value) {
                  return value!.isEmpty ? 'Enter blog description' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter blog description',
                    labelText: 'Description',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  return value!.isEmpty ? 'Enter your name' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your name',
                    labelText: 'Your name',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                child: Center(
                    child: image == null
                        ? IconButton(
                            onPressed: () async {
                              final pickedImg = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedImg != null) {
                                setState(() {
                                  image = File(pickedImg.path);
                                });
                              } else {
                                print('No Image has chosen');
                              }
                            },
                            icon: Icon(Icons.image))
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.file(image!.absolute,height: 150,),
                            IconButton(onPressed: () async{
                              String imgId = DateTime.now().millisecondsSinceEpoch.toString();
                               Reference referenceDirImages = referenceRoot.child("Blog-Images");
                               Reference referenceImageToUpload = referenceDirImages.child(imgId);

                              if(image != null){
                                try {
                                  await referenceImageToUpload.putFile(image!);
                                  imgUrl = await referenceImageToUpload.getDownloadURL();
                                  showToast('Image uploaded successfully! Now submit');
                                } catch (e) {
                                  showToast(e.toString());
                                }
                              }
                              return;

                            }, icon: Icon(Icons.upload))
                          ],
                        )),
              ),
              MyButton(
                  title: 'Submit',
                  onpress: () {
                    if (_formkey.currentState!.validate() && image != null) {
                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      String time =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());
                      print(time);
                      firestore.doc(id).set({
                        'title': titleController.text.toString(),
                        'desc': descController.text.toString(),
                        'name': nameController.text.toString(),
                        'id': id,
                        'time': time.toString(),
                        'imgUrl':imgUrl.toString()
                      }).then((value) {
                        showToast('Your blog has been added');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).catchError((err) {
                        showToast(err.toString());
                      });
                    } else {
                      showToast('Provide blog details first');
                    }
                  })
            ],
          ),
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
