import 'package:flutter/material.dart';
import 'package:meal_order/cubit/appCubit.dart';
import 'package:meal_order/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class BonAppetit extends StatelessWidget {
  const BonAppetit({Key? key}) : super(key: key);

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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.model != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You selected ${cubit.model!.selectedFood}",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent, fontSize: 30)),
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Have bon appetit!",
                      style:
                          TextStyle(color: Colors.deepOrangeAccent, fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
