import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String title;
  final VoidCallback onpress;

  const MyButton({Key? key,required this.title,required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: Colors.deepPurple,
        child: Text(title,style: TextStyle(
          color: Colors.white,
          fontSize: 17
        ),),
        onPressed: onpress,
      ),
    );
  }
}