import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/components/button.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
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
                height: 30,
              ),
              MyButton(
                  title: 'Register',
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      auth
                          .createUserWithEmailAndPassword(
                              email: emailController.text.toString().trim(),
                              password:
                                  passwordController.text.toString().trim())
                          .then((value) {
                        showToast('Account has created successfully');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).catchError((error) {
                        showToast(error.toString());
                      });
                    } else {
                      showToast('404 bad error');
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
