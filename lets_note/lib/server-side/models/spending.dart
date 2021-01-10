
import 'package:lets_note/server-side/mockup-data/data.dart';
import 'package:lets_note/server-side/models/note-datum.dart';

import 'dart:convert';

import 'dart:convert';

SpendingModel spendingFromJson(String str) => SpendingModel.fromJson(json.decode(str));

String spendingToJson(SpendingModel data) => json.encode(data.toJson());

  class SpendingModel implements NoteItem {
  //loại chi tiêu  -1 | thu nhập 1
  SpendingType spendingType;
  String note; //
  int money;
  SpendingModel({this.note,this.id, this.spendingType, this.dateCreated,this.userId,this.dateUpdate,this.money});
  @override
  String getTitle() {
    print(this.spendingType);
    String sign= this.spendingType.type==1 ?"+":"-";

    return '${this.spendingType.title } ( ${sign} ${this.money.toString()} VND )';
  }

  @override
  int getType() {
    return NoteType.spending.index ;
  }

  @override
  int id;

  @override
  DateTime dateCreated;

  @override
  DateTime dateUpdate;

  @override
  int userId;

  factory SpendingModel.fromJson(Map<String, dynamic> json) => SpendingModel(
    id: json["id"],
    userId: json["userId"],
    money: json["money"],
    spendingType: SpendingType.fromJson(json["spendingType"]),
    note: json["content"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    dateUpdate: DateTime.parse(json["dateUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "money":money,
    "spendingType": spendingType.toJson(),
    "content": note,
    "dateCreated": dateCreated.toIso8601String(),
    "dateUpdate": dateUpdate.toIso8601String(),
  };
}
