import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier{
  bool isLogin=false;
  int userId;
  String userAccount;
  String userName;

  bool changeStatus(){
    this.isLogin=!this.isLogin;
    notifyListeners();
    return this.isLogin;
  }
  void updateData({int userId,String userName,String userAccount}){
   this.userAccount=userAccount;
   this.userName=userName;
   this.userId=userId;
    notifyListeners();

  }
}