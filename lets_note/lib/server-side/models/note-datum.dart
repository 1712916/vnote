

class NoteItem {
  int id;
  int userId;
  DateTime dateCreated;
  DateTime dateUpdate;
  int getType() {}
  String getTitle() {}
}

// class CheckList implements NoteItem {
//   String title;
//   List<CheckDatum> content;
//
//   CheckList({this.content,this.title});
//
//   @override
//   String getTitle() {
//     return '${this.title} (+${this.content.length-1})';
//   }
//
//   @override
//   NoteType getType() {
//     return NoteType.checkList ;
//   }
//
//   @override
//   String id;
// }
//
// class CheckDatum {
//   bool isChecked;
//   String content;
//   CheckDatum({this.isChecked, this.content});
// }




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
  spending, //chi tiêu
  reminder, //lời nhắc
  checkList,
}

