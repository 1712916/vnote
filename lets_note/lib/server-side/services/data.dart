import 'package:lets_note/server-side/mockup-data/data.dart';

class DataServices{
  static getTodayData({int userId}){
    //check today có data chưa
    //nếu có thì trả về có
    //nếu không thì trả về
    return NoteData.getTodayData(userId:userId );
  }
}