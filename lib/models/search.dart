class CategoryIdallSearchModel {
  int? id;
  String? title;
  String? imgUrl;
  String? link;
  String? details;
  String? offer;
  String? saleCode;
  String? phoneNumber;
  String? storAddress;
  bool? acceptLocoCard;
  int? categoryId;
  Category? category;
  int? countryId;
  Country? country;
  List<StoreSlider> storeSlider;

  CategoryIdallSearchModel({
    this.id,
    this.title,
    this.imgUrl,
    this.link,
    this.details,
    this.offer,
    this.saleCode,
    this.phoneNumber,
    this.acceptLocoCard,
    this.categoryId,
    this.category,
    this.countryId,
    this.country,
    this.storAddress,
    required this.storeSlider,
  });

  factory CategoryIdallSearchModel.fromJson(Map<String, dynamic> json) {
    return CategoryIdallSearchModel(
      id: json['Id'],
      title: json['Stor_Title'],
      imgUrl: json['Stor_ImgUrl'],
      link: json['Stor_Link'],
      details: json['Stor_Deteils'],
      storAddress: json['Stor_Address'],
      offer: json['Stor_Offer'],
      saleCode: json['Stor_SaleCode'],
      phoneNumber: json['Stor_PhoneNumber'],
      acceptLocoCard: json['Accept_Loco_Card'],
      categoryId: json['CatgId'],
      category: Category.fromJson(json['Categories']),
      countryId: json['CountId'],
      country: Country.fromJson(json['Countries']),
      storeSlider: List<StoreSlider>.from(json["StoreSlider"].map((x) => StoreSlider.fromJson(x))),
    );
  }
}

class Category {
  int? id;
  String? name;
  String? iconUrl;

  Category({
    this.id,
    this.name,
    this.iconUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['categ_Name'],
      iconUrl: json['cated_IconUrl'],
    );
  }
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


}

class Country {
  int? id;
  String? name;
  String? flagUrl;

  Country({
    this.id,
    this.name,
    this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['cont_Name'],
      flagUrl: json['cont_FlagUrl'],
    );
  }
}