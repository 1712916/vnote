import 'package:lets_note/server-side/mockup-data/data.dart';

class DataServices{
  static getTodayData({int userId}){
    //check today có data chưa
    //nếu có thì trả về có
    //nếu không thì trả về
    return NoteData.getTodayData(userId:userId );
  }
  static getDataById({int id}){
    //check today có data chưa
    //nếu có thì trả về có
    //nếu không thì trả về
    return NoteData.findById(id:id );
  }
  static updateDataById({int id,dynamic datum}){
    //check today có data chưa
    //nếu có thì trả về có
    //nếu không thì trả về
    return NoteData.updateById(id:id,datum: datum);
  }
}