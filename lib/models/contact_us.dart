// To parse this JSON data, do
//
//     final contactUs = contactUsFromJson(jsonString);

import 'dart:convert';

ContactUs contactUsFromJson(String str) => ContactUs.fromJson(json.decode(str));

String contactUsToJson(ContactUs data) => json.encode(data.toJson());

class ContactUs {
  ContactUs({
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

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
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
    required this.aboutApp,
    required this.ourVision,
    required this.ourGoals,
    required this.insatLink,
    required this.faceebokkLink,
    required this.linkdLinLink,
    required this.twitterLink,
  });

  int id;
  String aboutApp;
  String ourVision;
  String ourGoals;
  String insatLink;
  String faceebokkLink;
  String linkdLinLink;
  String twitterLink;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["Id"],
    aboutApp: json["About_App"],
    ourVision: json["Our_Vision"],
    ourGoals: json["Our_Goals"],
    insatLink: json["Insat_Link"],
    faceebokkLink: json["Faceebokk_Link"],
    linkdLinLink: json["LinkdLin_Link"],
    twitterLink: json["Twitter_Link"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "About_App": aboutApp,
    "Our_Vision": ourVision,
    "Our_Goals": ourGoals,
    "Insat_Link": insatLink,
    "Faceebokk_Link": faceebokkLink,
    "LinkdLin_Link": linkdLinLink,
    "Twitter_Link": twitterLink,
  };
}
