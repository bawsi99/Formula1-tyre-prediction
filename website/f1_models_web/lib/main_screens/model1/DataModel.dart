// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.result,
  });

  String result;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
  };
}
