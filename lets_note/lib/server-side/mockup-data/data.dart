import 'dart:convert';

import 'package:lets_note/server-side/models/simple-note.dart';
import 'package:lets_note/server-side/models/spending.dart';
import 'package:lets_note/server-side/models/user-account.dart';

class UserAccountData {
  static int _currentId=2;
  static List<UserAccount> accounts = [
    UserAccount(
        userId: 0,
        userName: "Kiều Phong",
        userAccount: "boss",
        userPassword: "1"),
    UserAccount(
        userId: 1,
        userName: "Vịnh Ngô",
        userAccount: "vinhngo",
        userPassword: "1"),
  ];

  static checkUserAccount({String userAccount, String userPassword}) {
    var result;

    for (int i = 0; i < accounts.length; i++) {
      if (accounts[i].userAccount == userAccount &&
          accounts[i].userPassword == userPassword) {
        result = {
          "status": 200,
          "payload": {
            "userId": accounts[i].userId,
            "userAccount": accounts[i].userAccount,
            "userName": accounts[i].userName
          }
        };
        return  result;
      }
    }

    result = {
      "status": 404,
    };
    return  result;
  }
  static createNewAccount({String userAccount, String userPassword}){
    //check userAccount

    //add
    UserAccount newUser= UserAccount(
        userId: _currentId++,
        userName: userAccount+"_name",
        userAccount: userAccount,
        userPassword: userAccount);
    accounts.add(newUser);
    return jsonEncode({
      "status": 200,
    });
  }
}

class NoteData{
  static int _currentId=3;
  static List data=[
    SimpleNote(id: 2,userId: 1,title: "Đi chợ mua đồ tết",content: "1. Mua áo sơ mi trắng\n2. Mua quần jean",dateCreated: DateTime.now(),dateUpdate: DateTime.now()),

    SimpleNote(id: 0,userId: 0,title: "Đi chợ mua đồ tết",content: "1. Mua áo sơ mi trắng\n2. Mua quần jean",dateCreated: DateTime.now(),dateUpdate: DateTime.now()),
    Spending(id: 1,userId: 0,money: 30000,content: "Ăn uống",dateUpdate: DateTime.now(),dateCreated: DateTime.now(),spendingType: 0),
  ];

  static addNewDatum({dynamic datum}){
    datum.id=_currentId++;
    data.add(datum);
    return {
      "status": 200,
    };
  }

  static findById({int id}){
    for(int i=0;i<NoteData.data.length;i++){
      if(NoteData.data[i].id==id){
        return NoteData.data[i].toJson();
      }
    }
  }

  static getTodayData({int userId}){
    List result=[];
    for(int i=0;i<NoteData.data.length;i++){
      if(NoteData.data[i].userId==userId && DateTime.now().isSameDate(NoteData.data[i].dateCreated)){
        result.add({
          "id":NoteData.data[i].id,
          "title":NoteData.data[i].getTitle(),
          "typeNote":NoteData.data[i].getType(),
        });
      }
    }
    return {
      "status":200,
      "payload":result
    } ;
  }

}
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }
}

void main() {
 NoteData.addNewDatum( datum:SimpleNote(id: 0,userId: 0,title: "hahahaah đồ tết",content: "1. Mua áo sơ mi trắng\n2. Mua quần jean",dateCreated: DateTime.now(),dateUpdate: DateTime.now()));
print(NoteData.getTodayData(userId: 0));

}
