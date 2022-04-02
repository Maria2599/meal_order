import 'package:meal_order/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_order/model/FoodModel.dart';
import 'package:meal_order/model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/constants.dart';
import '../network/cache_helper.dart';

class AppCubit extends Cubit<States> {
  AppCubit() : super(appInitStates());

  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  FoodModel? foodModel;


  void getUsers(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
    .doc(CacheHelper.getData(key: 'uId'))
    .snapshots()
    .listen((value) {
        model =  UserModel.fromJson(value.data()!);
        emit(GetUserSuccessState());

  });}



  void selectFood({
  required String food
}){
    UserModel userModel = UserModel(
      name: model!.name,
      email: model!.email,
      uId: model!.uId,
      isAdmin: model!.isAdmin,
      selectedFood: food
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .update(userModel.toMap())
        .then((value) {
      getUsers();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
List foodDay=[];
  void getFood() {
    emit(GetFoodLoadingState());
    FirebaseFirestore.instance.collection('food')
        .snapshots()
    .listen((value) {
      foodDay=[];
      value.docs.forEach((element) {
        foodDay.add(FoodModel.fromJson(element.data()));
        foodModel =  FoodModel.fromJson(element.data());
        emit(GetFoodSuccessState());

      });
    });
  }
  
  void updateFood({
  required List food
}){
    FoodModel foodModel= FoodModel(todaysFood: food);
    FirebaseFirestore.instance
    .collection('food')
    .doc('kBpapMbEba9KmZD6cyvA')
    .update(foodModel.toMap())
    .then((value) {
      getFood();
    }).catchError((error){
      emit(UpdateFoodErrorState());
    });
  }




}
