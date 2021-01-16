import 'package:lets_note/client-side/services/data-services.dart';

class DataController{

  static getDataById({int id }){
    return DataServices.getDataById(dataId: id);
  }
  static getTodayData({int userId}){
    return  DataServices.getDataToday(userId: userId);
  }

  static updateDataById({int id, dynamic datum}){
    return  DataServices.updateDataById(dataId: id,datum: datum);
  }
  static searchData({int userId, dynamic filter}){
    return  DataServices.searchData(userId: userId,filter: filter);
  }
 
}