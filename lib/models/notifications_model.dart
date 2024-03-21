// To parse this JSON data, do
//
//     final notificationsModelReq = notificationsModelReqFromJson(jsonString);

import 'dart:convert';

NotificationsModelReq notificationsModelReqFromJson(String str) => NotificationsModelReq.fromJson(json.decode(str));

String notificationsModelReqToJson(NotificationsModelReq data) => json.encode(data.toJson());

class NotificationsModelReq {
  String? status;
  List<NotificationModel>? notificationsList;

  NotificationsModelReq({
    this.status,
    this.notificationsList,
  });

  factory NotificationsModelReq.fromJson(Map<String, dynamic> json) => NotificationsModelReq(
    status: json["status"],
    notificationsList: json["data"] == null ? [] : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": notificationsList == null ? [] : List<dynamic>.from(notificationsList!.map((x) => x.toJson())),
  };
}

class NotificationModel {
  dynamic id;
  String? itemId;
  String? title;
  String? detail;
  String? createdAt;
  String? type;
  dynamic amount;
  dynamic reason;
  dynamic body;
  dynamic accept;
  String? diff;

  NotificationModel({
    this.id,
    this.itemId,
    this.title,
    this.detail,
    this.createdAt,
    this.type,
    this.amount,
    this.reason,
    this.body,
    this.accept,
    this.diff,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    itemId: json["item_id"],
    title: json["title"],
    detail: json["detail"],
    createdAt: json["created_at"],
    type: json["type"],
    amount: json["amount"],
    reason: json["reason"],
    body: json["body"],
    accept: json["accept"],
    diff: json["diff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "title": title,
    "detail": detail,
    "created_at": createdAt,
    "type": type,
    "amount": amount,
    "reason": reason,
    "body": body,
    "accept": accept,
    "diff": diff,
  };
}
