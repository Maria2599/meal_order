import 'package:flutter/material.dart';

const TextFieldDecoration = InputDecoration(

  labelStyle: TextStyle(color: Colors.blueAccent,),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0))
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0))
  ),
  focusedBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0))
  ),
);

var uId;
