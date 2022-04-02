import 'package:flutter/material.dart';
import 'package:meal_order/HomeScreen.dart';
import 'package:meal_order/components/components.dart';
import 'package:meal_order/components/constants.dart';
import 'package:meal_order/components/rounded_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_order/cubit/appCubit.dart';
import 'package:meal_order/cubit/states.dart';
import 'package:meal_order/network/cache_helper.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var formkey = GlobalKey<FormState>();
var email = TextEditingController();
var password = TextEditingController();
bool? admin;

class _LoginScreenState extends State<LoginScreen> {
  bool isHidden = false;

  changePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,States>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          CacheHelper.saveData(key: 'uId', value: state.uId)
              .then((value) {
                navigateAndFinish(context, HomeScreen());
          });
        }
      },
      builder: (context,state){
       var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: 500,
                    child: Card(
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Order Meal",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              width: 600,
                              child: TextCustomFiled(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email can't be empty";
                                    } else if (!RegExp("^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-z]")
                                        .hasMatch(value)) {
                                      return "Enter valid email";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: TextFieldDecoration.copyWith(
                                    filled: true,
                                    fillColor: Colors.white70,
                                    labelText: "email",
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.blueAccent,
                                      size: 20.0,
                                    ),
                                  ),
                                  controller: email),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              width: 600,
                              child: TextCustomFiled(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "password cant be empty";
                                  } else if (value.length < 6) {
                                    return "Password must be more than 6 char";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: isHidden,
                                keyboardType: TextInputType.visiblePassword,
                                controller: password,
                                decoration: TextFieldDecoration.copyWith(
                                    filled: true,
                                    fillColor: Colors.white70,
                                    labelText: "password",
                                    prefixIcon: const Icon(
                                      Icons.password_rounded,
                                      color: Colors.blueAccent,
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: changePassword,
                                        icon: isHidden
                                            ? const Icon(
                                          Icons.lock_outline,
                                          color: Colors.blueAccent,
                                          size: 20.0,
                                        )
                                            : const Icon(
                                          Icons.lock_open,
                                          color: Colors.blueAccent,
                                          size: 22.0,
                                        ))),
                              ),
                            ),
                          SizedBox(
                            height: 50,
                          ),
                            RoundedButton(
                              title: "Login",
                              onPressed: () async{
                                if(formkey.currentState!.validate()){
                                  cubit.loginUser(email: email.text, password: password.text,isAdmin: admin);
                                }

                              },
                              color: Colors.blueAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
