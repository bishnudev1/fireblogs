import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fireblogs/components/button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController recorveryEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  return value!.isEmpty ? 'Enter your email first' : null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: Colors.deepPurple,
                    ),
                    hintText: 'Enter your email...',
                    labelText: 'Email',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  return value!.isEmpty ? 'Enter your password first' : null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.deepPurple,
                    ),
                    hintText: 'Enter your password...',
                    labelText: 'Password',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  height: 200,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: recorveryEmailController,
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'Enter valid email'
                                              : null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter recorvery email',
                                          labelText: 'Recorvery Email',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            auth
                                                .sendPasswordResetEmail(
                                                    email:
                                                        recorveryEmailController
                                                            .text
                                                            .toString()
                                                            .trim())
                                                .then((value) {
                                                  showToast('A recovery link has been sent to your email');
                                                  Navigator.pop(context);
                                                })
                                                .catchError((err) {
                                                  showToast(err.toString());
                                                });
                                          },
                                          child: Text('Reset'))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Forget?',
                        style:
                            TextStyle(fontSize: 17, color: Colors.deepPurple),
                      ))),
              SizedBox(
                height: 10,
              ),
              MyButton(
                  title: 'Login',
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      auth
                          .signInWithEmailAndPassword(
                              email: emailController.text.toString().trim(),
                              password:
                                  passwordController.text.toString().trim())
                          .then((value) {
                        showToast('You have signed in');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).catchError((err) {
                        showToast(err.toString());
                      });
                    } else {
                      showToast('404 bad error');
                    }
                  }),
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
