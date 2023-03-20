// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  QuestionModel({
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

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
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
    required this.question,
    required this.answer,
  });

  int id;
  String question;
  String answer;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["Id"],
    question: json["Question"],
    answer: json["Answer"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Question": question,
    "Answer": answer,
  };
}
