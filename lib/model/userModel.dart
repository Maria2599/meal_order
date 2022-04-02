class UserModel{
  String? email;
  String? name;
  String? uId;
  String? selectedFood;
  bool? isAdmin;

  UserModel({
    this.email,
    this.name,
    this.uId,
    this.selectedFood,
    this.isAdmin
});

  UserModel.fromJson(Map<String, dynamic> json){
    email= json['email'];
    name= json['name'];
    uId= json['uId'];
    selectedFood= json['selectedFood'];
    isAdmin= json['isAdmin'];
  }

  Map<String,dynamic> toMap(){
    return{
      'email':email,
      'name':name,
      'uId':uId,
      'selectedFood':selectedFood,
      'isAdmin':isAdmin,
  };
}
}