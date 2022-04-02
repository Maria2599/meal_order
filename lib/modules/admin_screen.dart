import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_order/components/rounded_button.dart';

import '../components/components.dart';
import '../components/constants.dart';
import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bon_appetit.dart';

var meal1 = TextEditingController();
var meal2 = TextEditingController();
var meal3 = TextEditingController();
var formkey = GlobalKey<FormState>();

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String? Food;
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getUsers()
        ..getFood(),
      child: BlocConsumer<AppCubit, States>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.model != null && cubit.foodDay.length > 0,
              fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
              builder: (BuildContext context) {
                return  Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                      child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .710,
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(

                                  children: [
                                    Text(DateFormat('EEEE').format(now)+"'s meals",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(
                                        0xFF1F0C50)),),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        key: formkey,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 500,
                                                height: 250,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 400,
                                                      child: TextCustomFiled(
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return '   Meal 1 CAN\'T BE EMPTY';
                                                            } else
                                                              return null;
                                                          },
                                                          keyboardType: TextInputType.name,
                                                          decoration:
                                                          TextFieldDecoration.copyWith(
                                                            label: Text("First Meal"),
                                                          ),
                                                          controller: meal1),
                                                    ),
                                                    Container(
                                                      height: 80,
                                                      width: 400,
                                                      child: TextCustomFiled(
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return '   Meal 2 CAN\'T BE EMPTY';
                                                            } else
                                                              return null;
                                                          },
                                                          keyboardType: TextInputType.text,
                                                          decoration:
                                                          TextFieldDecoration.copyWith(
                                                            label: Text("Second Meal"),
                                                          ),
                                                          controller: meal2),
                                                    ),
                                                    Container(
                                                      height: 80,
                                                      width: 400,
                                                      child: TextCustomFiled(
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return '   Meal 3 CAN\'T BE EMPTY';
                                                            } else
                                                              return null;
                                                          },
                                                          keyboardType: TextInputType.phone,
                                                          decoration:
                                                          TextFieldDecoration.copyWith(
                                                            label: Text("Third Meal"),
                                                          ),
                                                          controller: meal3),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                  top: 50.0),
                                              child: MaterialButton(
                                                minWidth: 150,
                                                height: 50,
                                                onPressed: () {
                                                  if (formkey.currentState!.validate()) {
                                                    List foodlist=[meal1.text,meal2.text,meal3.text];
                                                    cubit.updateFood(food: foodlist);
                                                  }
                                                },
                                                color: Colors.blue,
                                                child: Text(
                                                  'Edit Meals',
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 600,
                                              height: 200,
                                              child: Container(
                                                height: 300,
                                                width: double.infinity,
                                                child: ListView.separated(
                                                  itemBuilder: (context, index) {
                                                    var FD = cubit.foodModel!.todaysFood;
                                                    return buildFoodAdminItem(FD![index]);
                                                  },
                                                  separatorBuilder: (context, index) =>
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                  itemCount:
                                                  cubit.foodModel!.todaysFood!.length,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(top: 50.0),
                                            child: MaterialButton(
                                              minWidth: 150,
                                              height: 50,
                                              onPressed: () {
                                                if(Food != null) {
                                                  cubit.selectFood(food: Food!);
                                                  navigateTo(context, BonAppetit());
                                                }else{
                                                  Fluttertoast.showToast(
                                                      msg: "Please select one meal",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      backgroundColor: Colors.grey,
                                                      timeInSecForIosWeb: 1,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              },
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'Choose Meal',
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 20),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))),
                );
              },

            );
          }),
    );
  }

  Widget buildFoodAdminItem(String model) {
    return ListTile(
      title: Text(model),
      leading: Radio(
        value: model,
        groupValue: Food,
        onChanged: (value) {
          setState(() {
            Food = value.toString();
          });
        },
      ),
    );
  }
}
