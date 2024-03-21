import 'dart:convert';

AgentsModelReq agentsModelReqFromJson(String str) => AgentsModelReq.fromJson(json.decode(str));

String agentsModelReqToJson(AgentsModelReq data) => json.encode(data.toJson());

class AgentsModelReq {
  String? status;
  List<AgentModel>? agentsModelList;

  AgentsModelReq({
    this.status,
    this.agentsModelList,
  });

  factory AgentsModelReq.fromJson(Map<String, dynamic> json) => AgentsModelReq(
    status: json["status"],
    agentsModelList: json["data"] == null ? [] : List<AgentModel>.from(json["data"]!.map((x) => AgentModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": agentsModelList == null ? [] : List<dynamic>.from(agentsModelList!.map((x) => x.toJson())),
  };
}

class AgentModel {
  dynamic id;
  dynamic countryId;
  String? address;
  String? fullName;
  String? fullAddress;
  String? phone;
  int? sort;

  AgentModel({
    this.id,
    this.countryId,
    this.address,
    this.fullName,
    this.fullAddress,
    this.phone,
    this.sort,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
    id: json["id"],
    countryId: json["country_id"],
    address: json["address"],
    fullName: json["full_name"],
    fullAddress: json["full_address"],
    phone: json["phone"],
    sort: json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "address": address,
    "full_name": fullName,
    "full_address": fullAddress,
    "phone": phone,
    "sort": sort,
  };
}
