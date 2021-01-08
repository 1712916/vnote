
import 'package:lets_note/server-side/constants.dart';
import 'package:lets_note/server-side/services/data.dart';
import 'package:lets_note/server-side/services/login.dart';

void runServer(){
  serverManager();
}

void serverManager() {

}


class ServerManager{
  static listenToRequest({String requestName,dynamic data}){
    switch(requestName){
      case ConstantRequestName.login:
        return  LoginServices.login(userAccount: data["userAccount"].toString(),password:data["userPassword"].toString() );
      case  ConstantRequestName.loadTodayData:
        return DataServices.getTodayData(userId:data["userId"] );

    }
  }
}

void main(){

  print(  ServerManager.listenToRequest(requestName: ConstantRequestName.login,data: {
    "userAccount":"boss",
    "userPassword":"1"
  }));
}

