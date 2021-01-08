import 'dart:convert';

import 'package:lets_note/server-side/models/note-datum.dart';
SimpleNote simpleNoteFromJson(String str) => SimpleNote.fromJson(json.decode(str));

String simpleNoteToJson(SimpleNote data) => json.encode(data.toJson());

class SimpleNote implements NoteItem {
  String title;
  String content;

  SimpleNote({this.title,this.content,this.id,this.dateCreated,this.dateUpdate,this.userId});

  @override
  String getTitle() {
    return this.title;
  }

  @override
  int getType() {
    return NoteType.simpleNote.index;
  }

  @override
  int id;

  @override
  DateTime dateCreated;

  @override
  DateTime dateUpdate;

  @override
  int userId;
  factory SimpleNote.fromJson(Map<String, dynamic> json) => SimpleNote(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    content: json["content"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    dateUpdate: DateTime.parse(json["dateUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "content": content,
    "dateCreated": dateCreated.toIso8601String(),
    "dateUpdate": dateUpdate.toIso8601String(),
  };

}
