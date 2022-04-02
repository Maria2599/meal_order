import 'package:flutter/material.dart';
import 'package:meal_order/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<States>{
  LoginCubit(): super(appInitStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  final _auth = FirebaseAuth.instance;
  String s="";


  void loginUser({
  required String email,
    required String password,
    required bool? isAdmin
}){
    emit(LoginLoadingState());

    _auth.signInWithEmailAndPassword(email: email, password: password)
    .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      if (error.code == 'user-not-found') {
        s = "The email not found";
      } else if (error.code == 'invalid-email') {
        s = "The email is not valid";
      } else if (error.code == 'wrong-password') {
        s = "Password is wrong";
      }
      Fluttertoast.showToast(
          msg: s,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginErrorState(error: error.toString()));
    });
  }

}