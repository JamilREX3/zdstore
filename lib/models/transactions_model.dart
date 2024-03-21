// To parse this JSON data, do
//
//     final transactionsModelReq = transactionsModelReqFromJson(jsonString);

import 'dart:convert';

TransactionsModelReq transactionsModelReqFromJson(String str) => TransactionsModelReq.fromJson(json.decode(str));

String transactionsModelReqToJson(TransactionsModelReq data) => json.encode(data.toJson());

class TransactionsModelReq {
  String? status;
  TranActionsFullModel? tranActionsFullModel;

  TransactionsModelReq({
    this.status,
    this.tranActionsFullModel,
  });

  factory TransactionsModelReq.fromJson(Map<String, dynamic> json) => TransactionsModelReq(
    status: json["status"],
    tranActionsFullModel: json["data"] == null ? null : TranActionsFullModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": tranActionsFullModel?.toJson(),
  };
}

class TranActionsFullModel {
  List<Transaction>? transactions;
  double? totalPurchases;
  dynamic toClients;
  dynamic receive;
  int? profit;
  int? credit;

  TranActionsFullModel({
    this.transactions,
    this.totalPurchases,
    this.toClients,
    this.receive,
    this.profit,
    this.credit,
  });

  factory TranActionsFullModel.fromJson(Map<String, dynamic> json) => TranActionsFullModel(
    transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
    totalPurchases: json["total_purchases"]?.toDouble(),
    toClients: json["to_clients"],
    receive: json["receive"],
    profit: json["profit"],
    credit: json["credit"],
  );

  Map<String, dynamic> toJson() => {
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "total_purchases": totalPurchases,
    "to_clients": toClients,
    "receive": receive,
    "profit": profit,
    "credit": credit,
  };
}

class Transaction {
  int? id;
  String? reason;
  int? userId;
  String? amount;
  String? oldBalance;
  String? newBalance;
  DateTime? createdAt;

  Transaction({
    this.id,
    this.reason,
    this.userId,
    this.amount,
    this.oldBalance,
    this.newBalance,
    this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    reason: json["reason"],
    userId: json["user_id"],
    amount: json["amount"],
    oldBalance: json["old_balance"],
    newBalance: json["new_balance"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
    "user_id": userId,
    "amount": amount,
    "old_balance": oldBalance,
    "new_balance": newBalance,
    "created_at": createdAt?.toIso8601String(),
  };
}
