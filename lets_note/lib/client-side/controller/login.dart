
import 'package:lets_note/client-side/services/login.dart';


class LoginController{
  static login({String userAccount, String userPassword }){
    var response=LoginServices.loginRequest(userAccount: userAccount,userPassword:userPassword);

    return response;
  }
}
void main(){
  print(LoginController.login(userAccount: "boss",userPassword: "1"));
}