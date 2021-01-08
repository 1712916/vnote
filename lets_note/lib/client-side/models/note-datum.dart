class NoteItem {
  String id;
  NoteType getType() {}
  String getTitle() {}
}

class SimpleNote implements NoteItem {
  String title;
  String content;

  SimpleNote({this.title,this.content,this.id});

  @override
  String getTitle() {
    return this.title;
  }

  @override
  NoteType getType() {
    return NoteType.simpleNote;
  }

  @override
  String id;
}

class CheckList implements NoteItem {
  String title;
  List<CheckDatum> content;

  CheckList({this.content,this.title});

  @override
  String getTitle() {
    return '${this.title} (+${this.content.length-1})';
  }

  @override
  NoteType getType() {
    return NoteType.checkList ;
  }

  @override
  String id;
}

class CheckDatum {
  bool isChecked;
  String content;
  CheckDatum({this.isChecked, this.content});
}

class Spending implements NoteItem {
  List<SpendingDatum> content;
  Spending({this.content,this.id});
  @override
  String getTitle() {
    return '${this.content[0].content} (+${this.content.length})';
  }

  @override
  NoteType getType() {
    return NoteType.spending ;
  }

  @override
  String id;
}

class SpendingDatum {
  SpendingType spendingType; //loại chi tiêu | thu nhập
  String category; //
  double money;
  String content;

  SpendingDatum({this.spendingType, this.category, this.money, this.content});
}

class Reminder implements NoteItem {
  String title;
  DateTime time;

  Reminder({this.time,this.title,this.id});

  @override
  String getTitle() {
    return '${this.title}';
  }

  @override
  NoteType getType() {
    return NoteType.reminder ;
  }

  @override
  String id;
}

class ReminderDatum {
  DateTime time;
  String content;

  ReminderDatum({this.time, this.content});
}

enum NoteType {
  simpleNote,
  spending, //chi tiêu
  reminder, //lời nhắc
  checkList,
}

enum SpendingType { income, spending }
