// To parse this JSON data, do
//
//     final policyModel = policyModelFromJson(jsonString);

import 'dart:convert';

PolicyModel policyModelFromJson(String str) => PolicyModel.fromJson(json.decode(str));

String policyModelToJson(PolicyModel data) => json.encode(data.toJson());

class PolicyModel {
  PolicyModel({
    required this.records,
    this.record,
    required this.code,
    required this.status,
    required this.message,
  });

  List<Record> records;
  dynamic record;
  String code;
  String status;
  String message;

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
    records: List<Record>.from(json["Records"].map((x) => Record.fromJson(x))),
    record: json["Record"],
    code: json["Code"],
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Records": List<dynamic>.from(records.map((x) => x.toJson())),
    "Record": record,
    "Code": code,
    "Status": status,
    "Message": message,
  };
}

class Record {
  Record({
    required this.id,
    required this.deatils,
  });

  int id;
  String deatils;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["Id"],
    deatils: json["Deatils"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Deatils": deatils,
  };
}
