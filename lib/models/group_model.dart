

import 'dart:convert';

GroupModelReq groupModelReqFromJson(String str) => GroupModelReq.fromJson(json.decode(str));
String groupModelReqToJson(GroupModelReq data) => json.encode(data.toJson());

class GroupModelReq {
  String? status;
  Data? data;

  GroupModelReq({
    this.status,
    this.data,
  });

  factory GroupModelReq.fromJson(Map<String, dynamic> json) => GroupModelReq(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  List<GroupModel>? groups;
  num? totalPurchases;

  Data({
    this.groups,
    this.totalPurchases,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    groups: json["groups"] == null ? [] : List<GroupModel>.from(json["groups"]!.map((x) => GroupModel.fromJson(x))),
    totalPurchases: json["total_purchases"],
  );

  Map<String, dynamic> toJson() => {
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x.toJson())),
    "total_purchases": totalPurchases,
  };
}

class GroupModel {
  int? id;
  String? name;
  String? logo;
  String? need;

  GroupModel({
    this.id,
    this.name,
    this.logo,
    this.need,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    need: json["need"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "need": need,
  };
}
