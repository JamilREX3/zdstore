// To parse this JSON data, do
//
//     final allOrdersLogReq = allOrdersLogReqFromJson(jsonString);

import 'dart:convert';

AllOrdersLogReq allOrdersLogReqFromJson(String str) => AllOrdersLogReq.fromJson(json.decode(str));

String allOrdersLogReqToJson(AllOrdersLogReq data) => json.encode(data.toJson());

class AllOrdersLogReq {
  String? status;
  List<OrderModel>? ordersList;

  AllOrdersLogReq({
    this.status,
    this.ordersList,
  });

  factory AllOrdersLogReq.fromJson(Map<String, dynamic> json) => AllOrdersLogReq(
    status: json["status"],
    ordersList: json["data"] == null ? [] : List<OrderModel>.from(json["data"]!.map((x) => OrderModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": ordersList == null ? [] : List<dynamic>.from(ordersList!.map((x) => x.toJson())),
  };
}

class OrderModel {
  String? id;
  String? price;
  num? quantity;
  int? accept;
  dynamic data;
  DateTime? createdAt;
  String? updatedAt;
  int? fromApi;
  String? productName;
  String? currencyCode;
  num? fontSize;
  String? currencyPrice;
  String? categoryName;
  String? productPhoto;
  String? eid;
  String? status;
  List<Replay>? replay;
  List<Transfer>? transfer;
  num? totalPrice;

  OrderModel({
    this.id,
    this.price,
    this.quantity,
    this.accept,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.fromApi,
    this.productName,
    this.currencyCode,
    this.fontSize,
    this.currencyPrice,
    this.categoryName,
    this.productPhoto,
    this.eid,
    this.status,
    this.replay,
    this.transfer,
    this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    price: json["price"].toString(),
    quantity: json["quantity"],
    accept: json["accept"],
    data: json["data"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    fromApi: json["from_api"],
    productName: json["product_name"],
    currencyCode: json["currencyCode"],
    fontSize: json["font_size"],
    currencyPrice: json["currencyPrice"],
    categoryName: json["category_name"],
    productPhoto: json["product_photo"],
    eid: json["eid"],
    status: json["status"],
    replay: json["replay"] == null ? [] : List<Replay>.from(json["replay"]!.map((x) => Replay.fromJson(x))),
    transfer: json["transfer"] == null ? [] : List<Transfer>.from(json["transfer"]!.map((x) => Transfer.fromJson(x))),
    totalPrice: json["total_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "quantity": quantity,
    "accept": accept,
    "data": data,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "from_api": fromApi,
    "product_name": productName,
    "currencyCode": currencyCode,
    "font_size": fontSize,
    "currencyPrice": currencyPrice,
    "category_name": categoryName,
    "product_photo": productPhoto,
    "eid": eid,
    "status": status,
    "replay": replay == null ? [] : List<dynamic>.from(replay!.map((x) => x.toJson())),
    "transfer": transfer == null ? [] : List<dynamic>.from(transfer!.map((x) => x.toJson())),
    "total_price": totalPrice,
  };
}

class DataClass {
  String? data;
  String? walletAddress;
  String? empty;
  String? dataSimNumber;
  String? simNumber;

  DataClass({
    this.data,
    this.walletAddress,
    this.empty,
    this.dataSimNumber,
    this.simNumber,
  });

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    data: json["عنوان المحفظة"],
    walletAddress: json["Wallet Address"],
    empty: json["ادخل الايدي الاعب"],
    dataSimNumber: json["SIM number"],
    simNumber: json["SIM Number"],
  );

  Map<String, dynamic> toJson() => {
    "عنوان المحفظة": data,
    "Wallet Address": walletAddress,
    "ادخل الايدي الاعب": empty,
    "SIM number": dataSimNumber,
    "SIM Number": simNumber,
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
    replay: json["replay"] == null ? [] : List<String>.from(json["replay"]!.map((x) => x)),
    objectionId: json["objection_id"],
    accept: json["accept"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "replay": replay == null ? [] : List<dynamic>.from(replay!.map((x) => x)),
    "objection_id": objectionId,
    "accept": accept,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Transfer {
  int? id;
  int? orderId;
  String? oldBalance;
  String? newBalance;
  String? amount;

  Transfer({
    this.id,
    this.orderId,
    this.oldBalance,
    this.newBalance,
    this.amount,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
    id: json["id"],
    orderId: json["order_id"],
    oldBalance: json["old_balance"],
    newBalance: json["new_balance"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "old_balance": oldBalance,
    "new_balance": newBalance,
    "amount": amount,
  };
}
