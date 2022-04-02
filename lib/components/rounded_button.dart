import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({this.color, required this.title, required this.onPressed});

  final Color? color;
  final String? title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      elevation: 6.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(title!,
        style: TextStyle(color: Colors.white,fontSize: 19.0),),
        minWidth: 350,
        height: 50,
      ),
    );
  }
}
