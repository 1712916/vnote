import 'package:intl/intl.dart';

class MyFormatDate{

  static getDateString({DateTime dateTime}){
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(dateTime);
    return formatted;
  }
}