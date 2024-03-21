class CategoryContentModelReq {
  String? status;
  CategoryContentModel? homeContentModel;

  CategoryContentModelReq({this.status, this.homeContentModel});

  CategoryContentModelReq.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    homeContentModel =
        json['data'] != null ? CategoryContentModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (homeContentModel != null) {
      data['data'] = homeContentModel!.toJson();
    }
    return data;
  }
}

class CategoryContentModel {
  String? name;
  dynamic banner;
  List<ProductModel>? products;
  List<CategoryModel>? categories;

  CategoryContentModel({this.name, this.banner, this.products, this.categories});

  CategoryContentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    banner = json['banner'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['banner'] = banner;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel extends Sortable{





  int? id;
  dynamic categoryName;
  num? price;
  int? visible;

  int? sort;
  int? currencyId;
  bool? available;
  dynamic hint;
  dynamic checkName;
  String? productCurrencyPrice;
  dynamic categoryAvailable;
  dynamic categoryVisible;
  dynamic categoryApiVisible;
  String? groupPriceType;
  dynamic categoryPhoto;
  dynamic flag;
  int? priceQty;
  String? apiServiceName;
  dynamic apiAmount;
  String? serviceId;
  dynamic banner;
  dynamic color;
  dynamic apiName;
  int? apiVisible;
  String? productName;
  int? categoryId;
  String? photo;
  int? fontSize;
  String? description;
  int? favoriteCount;
  num? basePrice;
  bool? offer;
  bool? isCredit;
  List<Requires>? requires;
  Amount? amount;

  @override
  int? get sortValue => sort;



  ProductModel(
      {this.id,
      this.categoryName,
      this.price,
      this.visible,
      this.sort,
      this.currencyId,
      this.available,
      this.hint,
      this.checkName,
      this.productCurrencyPrice,
      this.categoryAvailable,
      this.categoryVisible,
      this.categoryApiVisible,
      this.groupPriceType,
      this.categoryPhoto,
      this.flag,
      this.priceQty,
      this.apiServiceName,
      this.apiAmount,
      this.serviceId,
      this.banner,
      this.color,
      this.apiName,
      this.apiVisible,
      this.productName,
      this.categoryId,
      this.photo,
      this.fontSize,
      this.description,
      this.favoriteCount,
      this.basePrice,
      this.offer,
      this.isCredit,
      this.requires,
      this.amount});





  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    price = json['price'];
    visible = json['visible'];
    sort = json['sort'];
    currencyId = json['currency_id'];
    available = json['available'];
    hint = json['hint'];
    checkName = json['check_name'];
    productCurrencyPrice = json['product_currency_price'];
    categoryAvailable = json['category_available'];
    categoryVisible = json['category_visible'];
    categoryApiVisible = json['category_api_visible'];
    groupPriceType = json['group_price_type'];
    categoryPhoto = json['category_photo'];
    flag = json['flag'];
    priceQty = json['price_qty'];
    apiServiceName = json['api_service_name'];
    apiAmount = json['apiAmount'];
    serviceId = json['service_id'];
    banner = json['banner'];
    color = json['color'];
    apiName = json['api_name'];
    apiVisible = json['api_visible'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    photo = json['photo'];
    fontSize = json['font_size'];
    description = json['description'];
    favoriteCount = json['favorite_count'];
    basePrice = json['base_price'];
    offer = json['offer'];
    isCredit = json['isCredit'];
    if (json['requires'] != null) {
      requires = <Requires>[];
      json['requires'].forEach((v) {
        requires!.add(Requires.fromJson(v));
      });
    }
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['price'] = price;
    data['visible'] = visible;
    data['sort'] = sort;
    data['currency_id'] = currencyId;
    data['available'] = available;
    data['hint'] = hint;
    data['check_name'] = checkName;
    data['product_currency_price'] = productCurrencyPrice;
    data['category_available'] = categoryAvailable;
    data['category_visible'] = categoryVisible;
    data['category_api_visible'] = categoryApiVisible;
    data['group_price_type'] = groupPriceType;
    data['category_photo'] = categoryPhoto;
    data['flag'] = flag;
    data['price_qty'] = priceQty;
    data['api_service_name'] = apiServiceName;
    data['apiAmount'] = apiAmount;
    data['service_id'] = serviceId;
    data['banner'] = banner;
    data['color'] = color;
    data['api_name'] = apiName;
    data['api_visible'] = apiVisible;
    data['product_name'] = productName;
    data['category_id'] = categoryId;
    data['photo'] = photo;
    data['font_size'] = fontSize;
    data['description'] = description;
    data['favorite_count'] = favoriteCount;
    data['base_price'] = basePrice;
    data['offer'] = offer;
    data['isCredit'] = isCredit;
    if (requires != null) {
      data['requires'] = requires!.map((v) => v.toJson()).toList();
    }
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    return data;
  }








}

class Requires {
  String? name;
  String? question;
  int? productId;
  int? id;
  String? type;
  dynamic typeValue;

  Requires(
      {this.name,
      this.question,
      this.productId,
      this.id,
      this.type,
      this.typeValue});

  Requires.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    question = json['question'];
    productId = json['product_id'];
    id = json['id'];
    type = json['type'];

    if (json['type_value'] != null) {
      if (json['type_value'] is List) {
        typeValue = json['type_value'].cast<String>();
      } else if (json['type_value'] is Map) {
        typeValue = Map<String, dynamic>.from(json['type_value']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['question'] = question;
    data['product_id'] = productId;
    data['id'] = id;
    data['type'] = type;
    data['type_value'] = typeValue;
    return data;
  }
}

class Amount {
  dynamic min;
  dynamic max;

  Amount({this.min, this.max});

  Amount.fromJson(Map<String, dynamic> json) {
    min = json['min'].toString();
    max = json['max'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

class CategoryModel extends Sortable{
  int? id;
  String? name;
  int? available;
  int? visible;
  int? apiVisible;
  String? photo;
  int? sort;
  int? parentId;
  int? fontSize;
  dynamic parentName;
  dynamic flag;
  dynamic color;
  int? productsCount;
  int? categoriesCount;

  @override
  int? get sortValue => sort;

  CategoryModel(
      {this.id,
      this.name,
      this.available,
      this.visible,
      this.apiVisible,
      this.photo,
      this.sort,
      this.parentId,
      this.fontSize,
      this.parentName,
      this.flag,
      this.color,
      this.productsCount,
      this.categoriesCount});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    available = json['available'];
    visible = json['visible'];
    apiVisible = json['api_visible'];
    photo = json['photo'];
    sort = json['sort'];
    parentId = json['parent_id'];
    fontSize = json['font_size'];
    parentName = json['parent_name'];
    flag = json['flag'];
    color = json['color'];
    productsCount = json['products_count'];
    categoriesCount = json['categories_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['available'] = available;
    data['visible'] = visible;
    data['api_visible'] = apiVisible;
    data['photo'] = photo;
    data['sort'] = sort;
    data['parent_id'] = parentId;
    data['font_size'] = fontSize;
    data['parent_name'] = parentName;
    data['flag'] = flag;
    data['color'] = color;
    data['products_count'] = productsCount;
    data['categories_count'] = categoriesCount;
    return data;
  }
}



abstract class Sortable {
  int? get sortValue;
}
