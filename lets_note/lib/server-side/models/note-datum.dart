class NoteItem {
  int id;
  int userId;
  DateTime dateCreated;
  DateTime dateUpdate;
  int getType() {}
  String getTitle() {}
}

class CheckListModel implements NoteItem {
  String title;
  List<CheckDatum> content=[];

  CheckListModel({this.id,this.userId,this.dateUpdate,this.dateCreated,this.title,this.content});

  @override
  String getTitle() {
    return '${this.title} (+${this.content.length-1})';
  }

  @override
  int getType() {
    return NoteType.checkList.index ;
  }

  @override
  int id;

  @override
  DateTime dateCreated;

  @override
  DateTime dateUpdate;

  @override
  int userId;
  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    content: List<CheckDatum>.from(json["content"].map((x)=>CheckDatum.fromJson(x))),
    dateCreated: DateTime.parse(json["dateCreated"]),
    dateUpdate: DateTime.parse(json["dateUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "content": content.map((e) => e.toJson()).toList(),
    "dateCreated": dateCreated.toIso8601String(),
    "dateUpdate": dateUpdate.toIso8601String(),
  };

}

class CheckDatum {
  bool isChecked;
  String content;
  CheckDatum({this.isChecked, this.content});

  factory CheckDatum.fromJson(Map<String, dynamic> json) => CheckDatum(
    isChecked: json["isChecked"],
    content: json["content"],

  );

  Map<String, dynamic> toJson() => {
    "isChecked": isChecked,
    "content": content,
  };

}




// class Reminder implements NoteItem {
//   String title;
//   DateTime time;
//
//   Reminder({this.time,this.title,this.id});
//
//   @override
//   String getTitle() {
//     return '${this.title}';
//   }
//
//   @override
//   NoteType getType() {
//     return NoteType.reminder ;
//   }
//
//   @override
//   String id;
// }
//
// class ReminderDatum {
//   DateTime time;
//   String content;
//
//   ReminderDatum({this.time, this.content});
// }

enum NoteType {
  simpleNote,
  spending, //chi tiêu//lời nhắc
  checkList,
}

