import 'dart:convert';
GlobalSearchModelReq globalSearchModelReqFromJson(String str) => GlobalSearchModelReq.fromJson(json.decode(str));
String globalSearchModelReqToJson(GlobalSearchModelReq data) => json.encode(data.toJson());
class GlobalSearchModelReq {
  String? status;
  GlobalSearchModel? globalSearchModel;

  GlobalSearchModelReq({
    this.status,
    this.globalSearchModel,
  });

  factory GlobalSearchModelReq.fromJson(Map<String, dynamic> json) => GlobalSearchModelReq(
    status: json["status"],
    globalSearchModel: json["data"] == null ? null : GlobalSearchModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": globalSearchModel?.toJson(),
  };
}
class GlobalSearchModel {
  List<SearchProduct>? searchProductsList;
  List<SearchOrder>? searchOrdersList;

  GlobalSearchModel({
    this.searchProductsList,
    this.searchOrdersList,
  });

  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) => GlobalSearchModel(
    searchProductsList: json["products"] == null ? [] : List<SearchProduct>.from(json["products"]!.map((x) => SearchProduct.fromJson(x))),
    searchOrdersList: json["orders"] == null ? [] : List<SearchOrder>.from(json["orders"]!.map((x) => SearchOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": searchProductsList == null ? [] : List<dynamic>.from(searchProductsList!.map((x) => x.toJson())),
    "orders": searchOrdersList == null ? [] : List<dynamic>.from(searchOrdersList!.map((x) => x.toJson())),
  };
}
class SearchOrder {
  int? id;
  DateTime? createdAt;
  int? quantity;
  //OrderData? data;
  String? productName;
  // String? adminName;
  int? accept;
  //Status? status;

  SearchOrder({
    this.id,
    this.createdAt,
    this.quantity,
   // this.data,
    this.productName,
   // this.adminName,
    this.accept,
   // this.status,
  });

  factory SearchOrder.fromJson(Map<String, dynamic> json) => SearchOrder(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    quantity: json["quantity"],
   // data: json["data"] == null ? null : OrderData.fromJson(json["data"]),
    productName: json["product_name"],
    //adminName: json["admin_name"],
    accept: json["accept"],
    //status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "quantity": quantity,
   // "data": data?.toJson(),
    "product_name": productName,
   // "admin_name": adminName,
    "accept": accept,
   // "status": statusValues.reverse[status],
  };
}
class SearchProduct {
  String? name;
  int? id;
  // bool? isStock;
  // bool? isCredit;

  SearchProduct({
    this.name,
    this.id,
    // this.isStock,
    // this.isCredit,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) => SearchProduct(
    name: json["name"],
    id: json["id"],
    // isStock: json["isStock"],
    // isCredit: json["isCredit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}