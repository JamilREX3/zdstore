// To parse this JSON data, do
//
//     final currencyModelReq = currencyModelReqFromJson(jsonString);

import 'dart:convert';

CurrencyModelReq currencyModelReqFromJson(String str) => CurrencyModelReq.fromJson(json.decode(str));

String currencyModelReqToJson(CurrencyModelReq data) => json.encode(data.toJson());

class CurrencyModelReq {
  String? status;
  List<CurrencyModel>? currenciesList;

  CurrencyModelReq({
    this.status,
    this.currenciesList,
  });

  factory CurrencyModelReq.fromJson(Map<String, dynamic> json) => CurrencyModelReq(
    status: json["status"],
    currenciesList: json["data"] == null ? [] : List<CurrencyModel>.from(json["data"]!.map((x) => CurrencyModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": currenciesList == null ? [] : List<dynamic>.from(currenciesList!.map((x) => x.toJson())),
  };
}

class CurrencyModel {
  dynamic id;
  String? name;
  String? symbol;
  String? code;
  dynamic price;

  CurrencyModel({
    this.id,
    this.name,
    this.symbol,
    this.code,
    this.price,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    code: json["code"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "code": code,
    "price": price,
  };
}
