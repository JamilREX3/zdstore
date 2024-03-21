// To parse this JSON data, do
//
//     final orderDetailsReq = orderDetailsReqFromJson(jsonString);

import 'dart:convert';

OrderDetailsReq orderDetailsReqFromJson(String str) =>
    OrderDetailsReq.fromJson(json.decode(str));

String orderDetailsReqToJson(OrderDetailsReq data) =>
    json.encode(data.toJson());

class OrderDetailsReq {
  String? status;
  OrderDetailsModel? orderDetailsModel;

  OrderDetailsReq({
    this.status,
    this.orderDetailsModel,
  });

  factory OrderDetailsReq.fromJson(Map<String, dynamic> json) =>
      OrderDetailsReq(
        status: json["status"],
        orderDetailsModel: json["data"] == null
            ? null
            : OrderDetailsModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": orderDetailsModel?.toJson(),
      };
}

class OrderDetailsModel {
  String? price; //done
  int? quantity; //done
  int? accept; //done
  int? cancel; //done
  Map<String, dynamic>? data; // done
  int? productId; //ignore
  String? dollar; //ignore
  int? fromApi; //ignore
  bool? allowObjection; //done
  DateTime? createdAt; //done
  String? updatedAt; //done
  int? enableObjection; //ignore
  String? productName; //done
  int? userId; //ignore
  String? currencyCode; //done
  String? id; //done
  String? enId; //ignore
  String? eid;  //ignore
  String? status; //ignore
  List<Replay>? replay;
  int? canCancel; // done
  String? diff; //done
  DateTime? fi;
  List<Objection>? objection;

  OrderDetailsModel({
    this.price,
    this.quantity,
    this.accept,
    this.cancel,
    this.data,
    this.productId,
    this.dollar,
    this.fromApi,
    this.allowObjection,
    this.createdAt,
    this.updatedAt,
    this.enableObjection,
    this.productName,
    this.userId,
    this.currencyCode,
    this.id,
    this.enId,
    this.eid,
    this.status,
    this.replay,
    this.canCancel,
    this.diff,
    this.fi,
    this.objection,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        price: json["price"],
        quantity: json["quantity"],
        accept: json["accept"],
        cancel: json["cancel"],
        //data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        data:json['data'] is Map? Map<String, dynamic>.from(json['data']):{},
        productId: json["product_id"],
        dollar: json["dollar"],
        fromApi: json["from_api"],
        allowObjection: json["allow_objection"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        enableObjection: json["enable_objection"],
        productName: json["product_name"],
        userId: json["user_id"],
        currencyCode: json["currencyCode"],
        id: json["id"],
        enId: json["en_id"],
        eid: json["eid"],
        status: json["status"],
        replay: json["replay"] == null
            ? []
            : List<Replay>.from(json["replay"]!.map((x) => Replay.fromJson(x))),
        canCancel: json["can_cancel"],
        diff: json["diff"],
        fi: json["fi"] == null ? null : DateTime.parse(json["fi"]),
        objection: json["objection"] == null
            ? []
            : List<Objection>.from(
                json["objection"]!.map((x) => Objection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "quantity": quantity,
        "accept": accept,
        "cancel": cancel,
        //"data": data?.toJson(),
        "data": data,
        "product_id": productId,
        "dollar": dollar,
        "from_api": fromApi,
        "allow_objection": allowObjection,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "enable_objection": enableObjection,
        "product_name": productName,
        "user_id": userId,
        "currencyCode": currencyCode,
        "id": id,
        "en_id": enId,
        "eid": eid,
        "status": status,
        "replay": replay == null
            ? []
            : List<dynamic>.from(replay!.map((x) => x.toJson())),
        "can_cancel": canCancel,
        "diff": diff,
        "fi": fi?.toIso8601String(),
        "objection": objection == null
            ? []
            : List<dynamic>.from(objection!.map((x) => x.toJson())),
      };
}

class DataData {
  String? walletAddress;

  DataData({
    this.walletAddress,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        walletAddress: json["Wallet Address"],
      );

  Map<String, dynamic> toJson() => {
        "Wallet Address": walletAddress,
      };
}

class Objection {
  int? objectionId;
  String? replay;
  String? result;

  Objection({
    this.objectionId,
    this.replay,
    this.result,
  });

  factory Objection.fromJson(Map<String, dynamic> json) => Objection(
        objectionId: json["objection_id"],
        replay: json["replay"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "objection_id": objectionId,
        "replay": replay,
        "result": result,
      };
}

class Replay {
  int? id;
  int? userId;
  int? orderId;
  List<String>? replay;
  int? objectionId;
  int? accept;
  DateTime? createdAt;

  Replay({
    this.id,
    this.userId,
    this.orderId,
    this.replay,
    this.objectionId,
    this.accept,
    this.createdAt,
  });

  factory Replay.fromJson(Map<String, dynamic> json) => Replay(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        replay: json["replay"] == null
            ? []
            : List<String>.from(json["replay"]!.map((x) => x)),
        objectionId: json["objection_id"],
        accept: json["accept"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "replay":
            replay == null ? [] : List<dynamic>.from(replay!.map((x) => x)),
        "objection_id": objectionId,
        "accept": accept,
        "created_at": createdAt?.toIso8601String(),
      };
}
