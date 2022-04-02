abstract class States {}

class appInitStates extends States {}

class LoginLoadingState extends States {}

class LoginSuccessState extends States {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends States {
  final String error;

  LoginErrorState({required this.error});
}

class GetUserLoadingState extends States {}

class GetUserSuccessState extends States {}

class GetUserErrorState extends States {}

class UserUpdateErrorState extends States {}

class GetFoodLoadingState extends States {}

class GetFoodSuccessState extends States {}

class GetFoodErrorState extends States {}

class UpdateFoodErrorState extends States {}

class GetAllUsersLoadingState extends States {}

class GetAllUsersSuccessState extends States {}

class GetAllUsersErrorState extends States {}

