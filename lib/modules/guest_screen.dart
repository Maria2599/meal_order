import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_order/components/components.dart';
import 'package:meal_order/cubit/appCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_order/model/FoodModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meal_order/modules/bon_appetit.dart';
import '../components/rounded_button.dart';
import '../cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
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
              fallback: (BuildContext context) =>
                  Center(child: CircularProgressIndicator()),
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEEE').format(now) + "'s meals",
                        style:const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F0C50)),
                      ),
                     const SizedBox(
                        height: 30,
                      ),
                   const Text(
                        "* What would you like to eat today?",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent, fontSize: 30),
                      ),
                    const  SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 300,
                        width: double.infinity,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var FD;
                            //if he wants to add all days in same time
                            // if(DateFormat('EEEE').format(now)== "Saturday")
                            //   FD = cubit.foodModel!.Saturday;
                            // else  FD = cubit.foodModel!.todaysFood;
                            FD = cubit.foodModel!.todaysFood;
                            return buildFoodItem(FD![index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: cubit.foodModel!.todaysFood!.length,
                        ),
                      ),
                      RoundedButton(
                        title: "Choose",
                        onPressed: () {
                          if (Food != null) {
                            cubit.selectFood(food: Food!);
                            navigateTo(context, BonAppetit());
                          } else {
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
                        color: Colors.black,
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget buildFoodItem(String model) {
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
