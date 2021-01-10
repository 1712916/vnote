import 'package:lets_note/server-side/constants.dart';
import 'package:lets_note/server-side/main.dart';

class DataServices{
  static Map getDataById({int dataId }){
    var response = ServerManager.listenToRequest(
        requestName: ConstantRequestName.loadDataById,
        data: {'dataId': dataId });
    return response;
  }
  static Map getDataToday({int userId}){
    var response = ServerManager.listenToRequest(
        requestName: ConstantRequestName.loadTodayData,
        data: {'userId': userId});
    return response;
  }
  static updateDataById({int dataId,dynamic datum}){
    var response = ServerManager.listenToRequest(
        requestName: ConstantRequestName.updateDataById,
        data: {'dataId': dataId,'datum':datum});
    return response;
  }
}