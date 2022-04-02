import 'package:flutter/material.dart';
import 'package:meal_order/HomeScreen.dart';
import 'package:meal_order/cubit/appCubit.dart';
import 'package:meal_order/cubit/login_cubit.dart';
import 'package:meal_order/network/cache_helper.dart';

import 'components/constants.dart';
import 'detectOS.dart';
import 'login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (PlatformInfo.isWeb()) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyDsq_UzGGKmzKJ5egPBPxjeOMklOzRiokI',
            appId: '1:824316973727:web:b8627429a1f63b666d48aa',
            messagingSenderId: '824316973727',
            projectId: 'mealorder-2b8de'));
  } else {
    await Firebase.initializeApp();
  }

  await CacheHelper.init();
  Widget widget;

  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getUsers()
            ..getFood(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
