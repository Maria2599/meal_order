import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_order/components/components.dart';
import 'package:meal_order/cubit/appCubit.dart';
import 'package:meal_order/login_screen.dart';
import 'package:meal_order/modules/admin_screen.dart';
import 'package:meal_order/modules/guest_screen.dart';
import 'package:meal_order/network/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'components/constants.dart';

import 'cubit/states.dart';
import 'detectOS.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getUsers()
        ..getFood(),
      child: BlocConsumer<AppCubit, States>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title:const Text(
                  "Meal Order",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          CacheHelper.removeData(key: 'uId').then((value) {
                            if(value) {
                              navigateAndFinish(context, LoginScreen());
                            }
                          });
                         });
                      },
                      child:const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              body: ConditionalBuilder(
                condition: cubit.model != null,
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
                builder: (contxet) {
                  return cubit.model!.isAdmin == true
                      ? AdminScreen()
                      : GuestScreen();
                  //  PlatformInfo.isWeb() ? AdminScreen() : GuestScreen(),
                },
              ));
        },
      ),
    );
  }
}
