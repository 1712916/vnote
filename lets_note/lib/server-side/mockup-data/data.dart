import 'dart:convert';

import 'package:lets_note/client-side/models/spending-type-model.dart';
import 'package:lets_note/client-side/models/today-response-model.dart';
import 'package:lets_note/server-side/models/note-datum.dart';
import 'package:lets_note/server-side/models/simple-note.dart';
import 'package:lets_note/server-side/models/spending.dart';
import 'package:lets_note/server-side/models/user-account.dart';

class UserAccountData {
  static int _currentId = 2;
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
        return result;
      }
    }

    result = {
      "status": 404,
    };
    return result;
  }

  static createNewAccount({String userAccount, String userPassword}) {
    //check userAccount

    //add
    UserAccount newUser = UserAccount(
        userId: _currentId++,
        userName: userAccount + "_name",
        userAccount: userAccount,
        userPassword: userAccount);
    accounts.add(newUser);
    return jsonEncode({
      "status": 200,
    });
  }
}

class NoteData {
  static int _currentId = 5;
  static List data = [
    SimpleNoteModel(
        id: 0,
        userId: 1,
        title: "Đi chợ mua đồ tết",
        content: "1. Mua áo sơ mi trắng\n2. Mua quần jean",
        dateCreated: DateTime.now(),
        dateUpdate: DateTime.now()),
    SimpleNoteModel(
        id: 1,
        userId: 0,
        title: "Đi chợ mua đồ tết",
        content: "1. Mua áo sơ mi trắng\n2. Mua quần jean",
        dateCreated: DateTime.now(),
        dateUpdate: DateTime.now()),
    SpendingModel(
        id: 2,
        userId: 0,
        money: 30000,
        note: "Ghi chú nè",
        dateUpdate: DateTime.now(),
        dateCreated: DateTime.now(),
        spendingType: SpendingType(type: -1,title: "ăn uống")),
    SpendingModel(
        id: 3,
        userId: 0,
        money: 30000,
        note: "Ghi chú nè",
        dateUpdate: DateTime.now(),
        dateCreated:  DateTime.parse("2020-01-10 20:18:04Z"),
        spendingType: SpendingType(type: -1,title: "ăn uống")),
    CheckListModel(
      id: 4,
      userId: 0,
      dateUpdate: DateTime.now(),
      dateCreated: DateTime.now(),
      title: "check list title",
      content: [
        CheckDatum(
          content: "Mua áo sơ mi",
          isChecked: true
        )
      ]

    )
  ];

  static addNewDatum({dynamic datum}) {
    datum.id = _currentId++;
    data.add(datum);
    return datum.id;
  }

  static findById({int id}) {
    for (int i = 0; i < NoteData.data.length; i++) {
      if (NoteData.data[i].id == id) {
        return NoteData.data[i].toJson();
      }
    }
  }

  static updateById({int id, dynamic datum}) {
    print("here ${id}");
    if (id == null) {
      print("here!!!!");
      return addNewDatum(datum: datum);
    } else {
      for (int i = 0; i < NoteData.data.length; i++) {
        if (NoteData.data[i].id == id) {
          NoteData.data[i] = datum;
          return  NoteData.data[i].id;
        }
      }
    }

  }

  static getTodayData({int userId}) {
    List result = [];
    for (int i = 0; i < NoteData.data.length; i++) {
      if (NoteData.data[i].userId == userId &&
          DateTime.now().isSameDate(NoteData.data[i].dateCreated)) {
        result.add({
          "id": NoteData.data[i].id,
          "title": NoteData.data[i].getTitle(),
          "typeNote": NoteData.data[i].getType(),
          "dateCreated": NoteData.data[i].dateCreated.toIso8601String(),
          "dateUpdate": NoteData.data[i].dateUpdate.toIso8601String(),
        });
      }
    }
    return {"status": 200, "payload": result};
  }
  static searchMethod({int userId, Map filter}) {
    List result = [];

    for (int i = 0; i < NoteData.data.length; i++) {
      if (getCondition(NoteData.data[i],userId,filter) ) {
        result.add({
          "id": NoteData.data[i].id,
          "title": NoteData.data[i].getTitle(),
          "typeNote": NoteData.data[i].getType(),
          "dateCreated": NoteData.data[i].dateCreated.toIso8601String(),
          "dateUpdate": NoteData.data[i].dateUpdate.toIso8601String(),
        });
      }
    }
    if(filter["sort"]!=null){

      if(filter["sort_type"]=="newest"){

        result.sort((a,b){
          return a.dateCreated.compareTo(b.dateCreated);
        });
      } else if(filter["sort_type"]=="oldest"){
        result.sort((a,b){
          return b.dateCreated.compareTo(a.dateCreated);
        });
      }
    }


    return {"status": 200, "payload": result};
  }

  static bool getCondition(var datum,var userId, var filter) {
      if(filter["type"]==null||filter["type"]==-1){
        return datum.userId==userId;
      }else{
        return datum.userId==userId &&filter["type"]==datum.getType();
      }

  }


}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {

    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

}


class SpendingType{

  String title;
  int type;
  SpendingType({this.title,this.type});
  factory SpendingType.fromJson(Map<String, dynamic> json) => SpendingType(
    title: json["title"],
    type: json["type"],

  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
  };
}

void main() {
  // NoteData.addNewDatum(
  //     datum: SimpleNoteModel(
  //         id: 0,
  //         userId: 0,
  //         title: "hahahaah đồ tết",
  //         content: "1. Mua áo sơ mi trắng\n2. Mua quần jean",
  //         dateCreated: DateTime.now(),
  //         dateUpdate: DateTime.now()));
  // print(NoteData.searchMethod(userId: 0));
// print(List<Payload>.from(NoteData.searchMethod(userId: 0)["payload"].map((x) => Payload.fromJson(x)))[0].dateUpdate);

}


