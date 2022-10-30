import 'package:fireblogs/components/button.dart';
import 'package:fireblogs/screens/login_screen.dart';
import 'package:fireblogs/screens/register_screen.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backwardsCompatibility: false,
        //centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.developer_board)),
          SizedBox(
            width: 10,
          )
        ],
        title: Text('Fire Blogs'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create your free account today for posting amazing blogs',
              style: TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Image(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 1,
              image: AssetImage("images/option.png"),
            ),
            SizedBox(
              height: 40,
            ),
            MyButton(
                title: 'Register',
                onpress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen()));
                }),
            SizedBox(
              height: 15,
            ),
            MyButton(
                title: 'Login',
                onpress: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
