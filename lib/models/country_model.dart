// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
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

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
    this.photo,
    required this.id,
    required this.contName,
    required this.contFlagUrl,
    this.stores,
  });

  dynamic photo;
  int id;
  String contName;
  String contFlagUrl;
  dynamic stores;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    photo: json["Photo"],
    id: json["Id"],
    contName: json["Cont_Name"],
    contFlagUrl: json["Cont_FlagUrl"],
    stores: json["Stores"],
  );

  Map<String, dynamic> toJson() => {
    "Photo": photo,
    "Id": id,
    "Cont_Name": contName,
    "Cont_FlagUrl": contFlagUrl,
    "Stores": stores,
  };
}
