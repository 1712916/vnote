
import 'dart:convert';

import 'package:lets_note/server-side/constants.dart';
import 'package:lets_note/server-side/models/note-datum.dart';
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
      case ConstantRequestName.loadDataById:
        return DataServices.getDataById(id: data["dataId"]);
      case ConstantRequestName.updateDataById:
        return DataServices.updateDataById(id: data["dataId"],datum: data["datum"]);
      case ConstantRequestName.searchData:
        return DataServices.searchData(userId: data["userId"],filter: data["filter"]);
    }
  }
}

