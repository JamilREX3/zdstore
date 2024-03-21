// To parse this JSON data, do
//
//     final appInfoReq = appInfoReqFromJson(jsonString);

import 'dart:convert';

AppInfoReq appInfoReqFromJson(String str) => AppInfoReq.fromJson(json.decode(str));

String appInfoReqToJson(AppInfoReq data) => json.encode(data.toJson());

class AppInfoReq {
  String? status;
  AppInfoModel? appInfo;

  AppInfoReq({
    this.status,
    this.appInfo,
  });

  factory AppInfoReq.fromJson(Map<String, dynamic> json) => AppInfoReq(
    status: json["status"],
    appInfo: json["data"] == null ? null : AppInfoModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": appInfo?.toJson(),
  };
}

class AppInfoModel {
  dynamic about;
  String? pageTitle;
  String? title;
  String? adsLine;
  String? logo;
  int? darkTheme;
  int? registry;
  dynamic facebook;
  dynamic twitter;
  dynamic telegram;
  String? whatsapp;
  dynamic youtube;
  dynamic instagram;
  List<Slide>? slide;
  dynamic shippingMethods;
  String? baseCurrency;
  dynamic stop;
  int? azBrand;
  int? brand;
  int? agent;
  int? currencyPrice;
  String? currencyCode;
  String? version;
  bool? forceUpdate;

  AppInfoModel({
    this.about,
    this.pageTitle,
    this.title,
    this.adsLine,
    this.logo,
    this.darkTheme,
    this.registry,
    this.facebook,
    this.twitter,
    this.telegram,
    this.whatsapp,
    this.youtube,
    this.instagram,
    this.slide,
    this.shippingMethods,
    this.baseCurrency,
    this.stop,
    this.azBrand,
    this.brand,
    this.agent,
    this.currencyPrice,
    this.currencyCode,
    this.version,
    this.forceUpdate,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => AppInfoModel(
    about: json["about"],
    pageTitle: json["page_title"],
    title: json["title"],
    adsLine: json["ads_line"],
    logo: json["logo"],
    darkTheme: json["dark_theme"],
    registry: json["registry"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    telegram: json["telegram"],
    whatsapp: json["whatsapp"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    slide: json["slide"] == null ? [] : List<Slide>.from(json["slide"]!.map((x) => Slide.fromJson(x))),
    shippingMethods: json["shipping_methods"],
    baseCurrency: json["base_currency"],
    stop: json["stop"],
    azBrand: json["az_brand"],
    brand: json["brand"],
    agent: json["agent"],
    currencyPrice: json["currencyPrice"],
    currencyCode: json["currencyCode"],
    version: json["version"],
    forceUpdate: json["force_update"],
  );

  Map<String, dynamic> toJson() => {
    "about": about,
    "page_title": pageTitle,
    "title": title,
    "ads_line": adsLine,
    "logo": logo,
    "dark_theme": darkTheme,
    "registry": registry,
    "facebook": facebook,
    "twitter": twitter,
    "telegram": telegram,
    "whatsapp": whatsapp,
    "youtube": youtube,
    "instagram": instagram,
    "slide": slide == null ? [] : List<dynamic>.from(slide!.map((x) => x.toJson())),
    "shipping_methods": shippingMethods,
    "base_currency": baseCurrency,
    "stop": stop,
    "az_brand": azBrand,
    "brand": brand,
    "agent": agent,
    "currencyPrice": currencyPrice,
    "currencyCode": currencyCode,
    "version": version,
    "force_update": forceUpdate,
  };
}

class Slide {
  String? img;
  dynamic to;

  Slide({
    this.img,
    this.to,
  });

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
    img: json["img"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "to": to,
  };
}
