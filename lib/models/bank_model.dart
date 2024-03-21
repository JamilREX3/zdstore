import 'dart:convert';

BankModelReq bankModelReqFromJson(String str) =>
    BankModelReq.fromJson(json.decode(str));

class BankModelReq {
  String? status;
  List<BankModel>? banksList;

  BankModelReq({
    this.status,
    this.banksList,
  });

  factory BankModelReq.fromJson(Map<String, dynamic> json) => BankModelReq(
        status: json["status"],
        banksList: json["data"] == null
            ? []
            : List<BankModel>.from(
                json["data"]!.map((x) => BankModel.fromJson(x))),
      );
}

class BankModel {
  int? id;
  int? countryId;
  String? name;
  String? info;
  String? img;
  int? needImg;
  String? tax;
  dynamic deletedAt;
  int? sort;
  int? visible;
  String? min;
  String? max;
  int? currencyId;
  List<BankRequire>? bankRequire;

  BankModel({
    this.id,
    this.countryId,
    this.name,
    this.info,
    this.img,
    this.needImg,
    this.tax,
    this.deletedAt,
    this.sort,
    this.visible,
    this.min,
    this.max,
    this.currencyId,
    this.bankRequire,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["id"],
        countryId: json["country_id"],
        name: json["name"],
        info: json["info"],
        img: json["img"],
        needImg: json["need_img"],
        tax: json["tax"],
        deletedAt: json["deleted_at"],
        sort: json["sort"],
        visible: json["visible"],
        min: json["min"],
        max: json["max"],
        currencyId: json["currency_id"],
        bankRequire: json["bank_require"] == null
            ? []
            : List<BankRequire>.from(
                json["bank_require"]!.map((x) => BankRequire.fromJson(x))),
      );
}

class BankRequire {
  int? id;
  int? bankId;
  String? fieldName;
  String? type;
  Map<String, dynamic>? names;
  Map<String, dynamic>? placeholder;
  dynamic createdAt;
  dynamic updatedAt;

  BankRequire({
    this.id,
    this.bankId,
    this.fieldName,
    this.type,
    this.names,
    this.placeholder,
    this.createdAt,
    this.updatedAt,
  });

  factory BankRequire.fromJson(Map<String, dynamic> json) => BankRequire(
        id: json["id"],
        bankId: json["bank_id"],
        fieldName: json["field_name"],
        type: json["type"],
        names: json["name"],
        placeholder: json["placeholder"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
