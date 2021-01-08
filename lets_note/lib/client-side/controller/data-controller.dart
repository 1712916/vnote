import 'package:lets_note/client-side/services/data-services.dart';

class DataController{
  static getDataForSimpleNote({String dataId}){

  }
  static getTodayData({int userId}){
    return  DataServices.getDataToday(userId: userId);
  }
}