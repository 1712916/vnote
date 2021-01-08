import 'package:lets_note/server-side/models/note-datum.dart';

import 'dart:convert';

import 'dart:convert';

Spending spendingFromJson(String str) => Spending.fromJson(json.decode(str));

String spendingToJson(Spending data) => json.encode(data.toJson());

  class Spending implements NoteItem {
  int  spendingType; //loại chi tiêu  0 | thu nhập 1
  String content; //
  double money;
  Spending({this.content,this.id, this.spendingType, this.dateCreated,this.userId,this.dateUpdate,this.money});
  @override
  String getTitle() {
    return '${this.content} (+${this.content.length})';
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

  factory Spending.fromJson(Map<String, dynamic> json) => Spending(
    id: json["id"],
    userId: json["userId"],
    spendingType: json["spendingType"],
    content: json["content"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    dateUpdate: DateTime.parse(json["dateUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "spendingType": spendingType,
    "content": content,
    "dateCreated": dateCreated.toIso8601String(),
    "dateUpdate": dateUpdate.toIso8601String(),
  };
}
