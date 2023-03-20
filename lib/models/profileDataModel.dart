class ProfileDataModel {
  Record? record;
  String? code;
  String? status;
  String? message;

  ProfileDataModel({this.record, this.code, this.status, this.message});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    record =
    json['Record'] != null ? new Record.fromJson(json['Record']) : null;
    code = json['Code'];
    status = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['Record'] = this.record!.toJson();
    }
    data['Code'] = this.code;
    data['Status'] = this.status;
    data['Message'] = this.message;
    return data;
  }
}

class Record {
  String? id;
  String? name;
  String? email;
  String? userNAme;
  String? phone;
  String? imgUrl;
  Null? gender;
  Null? countryId;

  Record(
      {this.id,
        this.name,
        this.email,
        this.userNAme,
        this.phone,
        this.imgUrl,
        this.gender,
        this.countryId});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    email = json['Email'];
    userNAme = json['userNAme'];
    phone = json['Phone'];
    imgUrl = json['ImgUrl'];
    gender = json['Gender'];
    countryId = json['CountryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['userNAme'] = this.userNAme;
    data['Phone'] = this.phone;
    data['ImgUrl'] = this.imgUrl;
    data['Gender'] = this.gender;
    data['CountryId'] = this.countryId;
    return data;
  }
}