
import 'package:lets_note/server-side/mockup-data/data.dart';

class SpendingTypeList{
  static List<SpendingType> spending=[
    SpendingType(title: "Quần áo",type: -1),
    SpendingType(title: "Ăn uống",type: -1),
    SpendingType(title: "Tập Gym",type: -1),
    SpendingType(title: "Học Phí",type: -1),
    SpendingType(title: "Tiền trọ",type: -1),

  ];
  static List<SpendingType> income=[
    SpendingType(title: "Cho thuê" ,type: 1),
    SpendingType(title: "Tiền lương" ,type: 1),
    SpendingType(title: "Trợ cấp" ,type: 1),
    SpendingType(title: "Tiền bán app" ,type: 1),
  ];
  static getDefault(){
    return  SpendingType(title: "Ăn uống",type: -1);
  }
}



