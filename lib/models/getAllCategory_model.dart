// To parse this JSON data, do
//
//     final categoryIdallModel = categoryIdallModelFromJson(jsonString);

import 'dart:convert';

CategoryIdallModel categoryIdallModelFromJson(String str) => CategoryIdallModel.fromJson(json.decode(str));

String categoryIdallModelToJson(CategoryIdallModel data) => json.encode(data.toJson());

class CategoryIdallModel {
  CategoryIdallModel({
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

  factory CategoryIdallModel.fromJson(Map<String, dynamic> json) => CategoryIdallModel(
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
    required this.storTitle,
    required this.storImgUrl,
    required this.storLink,
    required this.storDeteils,
    required this.storOffer,
    required this.storSaleCode,
    required this.storPhoneNumber,
    required this.storAddress,
    required this.acceptLocoCard,
    required this.catgId,
    required this.categories,
    required this.countId,
    required this.countries,
    this.cityId,
    required this.cities,
    this.districId,
    required this.district,
    required this.storeSlider,
  });

  dynamic photo;
  int id;
  String storTitle;
  String storImgUrl;
  String storLink;
  String storDeteils;
  String storOffer;
  String storSaleCode;
  String storPhoneNumber;
  String storAddress;
  bool acceptLocoCard;
  int catgId;
  Categories categories;
  int countId;
  Countries countries;
  dynamic cityId;
  Cities cities;
  dynamic districId;
  District district;
  List<StoreSlider> storeSlider;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    photo: json["Photo"],
    id: json["Id"],
    storTitle: json["Stor_Title"],
    storImgUrl: json["Stor_ImgUrl"],
    storLink: json["Stor_Link"],
    storDeteils: json["Stor_Deteils"],
    storOffer: json["Stor_Offer"],
    storSaleCode: json["Stor_SaleCode"],
    storPhoneNumber: json["Stor_PhoneNumber"],
    storAddress: json["Stor_Address"],
    acceptLocoCard: json["Accept_Loco_Card"],
    catgId: json["CatgId"],
    categories: Categories.fromJson(json["Categories"]),
    countId: json["CountId"],
    countries: Countries.fromJson(json["Countries"]),
    cityId: json["CityId"],
    cities: Cities.fromJson(json["Cities"]),
    districId: json["DistricId"],
    district: District.fromJson(json["District"]),
    storeSlider: List<StoreSlider>.from(json["StoreSlider"].map((x) => StoreSlider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Photo": photo,
    "Id": id,
    "Stor_Title": storTitle,
    "Stor_ImgUrl": storImgUrl,
    "Stor_Link": storLink,
    "Stor_Deteils": storDeteils,
    "Stor_Offer": storOffer,
    "Stor_SaleCode": storSaleCode,
    "Stor_PhoneNumber": storPhoneNumber,
    "Stor_Address": storAddress,
    "Accept_Loco_Card": acceptLocoCard,
    "CatgId": catgId,
    "Categories": categories.toJson(),
    "CountId": countId,
    "Countries": countries.toJson(),
    "CityId": cityId,
    "Cities": cities.toJson(),
    "DistricId": districId,
    "District": district.toJson(),
    "StoreSlider": List<dynamic>.from(storeSlider.map((x) => x.toJson())),
  };
}

class Categories {
  Categories({
    required this.id,
    required this.categName,
    required this.catedIconUrl,
    this.stores,
  });

  int id;
  String categName;
  String catedIconUrl;
  dynamic stores;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["Id"],
    categName: json["Categ_Name"],
    catedIconUrl: json["Cated_IconUrl"],
    stores: json["Stores"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Categ_Name": categName,
    "Cated_IconUrl": catedIconUrl,
    "Stores": stores,
  };
}

class District {
  District({
    required this.id,
    required this.districtName,
    required this.citiesId,
    this.stores,
    this.cities,
  });

  int id;
  String districtName;
  int citiesId;
  dynamic stores;
  Cities? cities;

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["Id"],
    districtName: json["DistrictName"],
    citiesId: json["CitiesId"],
    stores: json["Stores"],
    cities: json["Cities"] == null ? null : Cities.fromJson(json["Cities"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "DistrictName": districtName,
    "CitiesId": citiesId,
    "Stores": stores,
    "Cities": cities?.toJson(),
  };
}

class Cities {
  Cities({
    required this.id,
    required this.cityName,
    required this.countriesId,
    required this.countries,
    this.stores,
    required this.district,
  });

  int id;
  String cityName;
  int countriesId;
  Countries countries;
  dynamic stores;
  List<District> district;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
    id: json["Id"],
    cityName: json["CityName"],
    countriesId: json["CountriesId"],
    countries: Countries.fromJson(json["Countries"]),
    stores: json["Stores"],
    district: List<District>.from(json["District"].map((x) => District.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CityName": cityName,
    "CountriesId": countriesId,
    "Countries": countries.toJson(),
    "Stores": stores,
    "District": List<dynamic>.from(district.map((x) => x.toJson())),
  };
}

class Countries {
  Countries({
    required this.id,
    required this.contName,
    required this.contFlagUrl,
    this.stores,
  });

  int id;
  String contName;
  String contFlagUrl;
  dynamic stores;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
    id: json["Id"],
    contName: json["Cont_Name"],
    contFlagUrl: json["Cont_FlagUrl"],
    stores: json["Stores"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Cont_Name": contName,
    "Cont_FlagUrl": contFlagUrl,
    "Stores": stores,
  };
}

class StoreSlider {
  StoreSlider({
    required this.id,
    required this.imageUrl,
    required this.storeId,
    this.stores,
  });

  int id;
  String imageUrl;
  int storeId;
  dynamic stores;

  factory StoreSlider.fromJson(Map<String, dynamic> json) => StoreSlider(
    id: json["Id"],
    imageUrl: json["ImageUrl"],
    storeId: json["StoreId"],
    stores: json["Stores"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ImageUrl": imageUrl,
    "StoreId": storeId,
    "Stores": stores,
  };
}
