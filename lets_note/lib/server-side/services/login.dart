import 'package:lets_note/client-side/services/login.dart';
import 'package:lets_note/server-side/mockup-data/data.dart';

class LoginServices{
  static login({String userAccount,String password }){

        return UserAccountData.checkUserAccount(userPassword: password,userAccount: userAccount);
  }
}

void main(){
  print(LoginServices.login(userAccount: "boss",password: "1"));
}