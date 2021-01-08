// To parse this JSON data, do
//
//     final todayDataResponseModel = todayDataResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:lets_note/client-side/controller/data-controller.dart';

TodayDataResponseModel todayDataResponseModelFromJson(String str) => TodayDataResponseModel.fromJson(json.decode(str));

String todayDataResponseModelToJson(TodayDataResponseModel data) => json.encode(data.toJson());

class TodayDataResponseModel {
  TodayDataResponseModel({
    this.status,
    this.payload,
  });

  int status;
  List<Payload> payload;

  factory TodayDataResponseModel.fromJson(Map<String, dynamic> json) => TodayDataResponseModel(
    status: json["status"],
    payload: List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}

class Payload {
  Payload({
    this.id,
    this.title,
    this.typeNote,
  });

  int id;
  String title;
  int typeNote;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    title: json["title"],
    typeNote: json["typeNote"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "typeNote": typeNote,
  };
}

void main(){
  // var response=DataController.getTodayData(userId: 0);
  // print("$response");
var response={
  "status":100,
  "payload":[]
};
jsonEncode(response);
  todayDataResponseModelFromJson(jsonEncode(response));
  // List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x)))
  // print("data $data");
//  print( Payload.fromJson({"id": 0, "title": "Đi chợ mua đồ tết", "typeNote": 0}).title);
}