class CountryModelReq {
  String? status;
  List<CountryModel>? countriesList;

  CountryModelReq({this.status, this.countriesList});

  CountryModelReq.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      countriesList = <CountryModel>[];
      json['data'].forEach((v) {
        countriesList!.add(CountryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (countriesList != null) {
      data['data'] = countriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryModel {
  String? name;
  int? id;
  String? lang;
  int? callingCode;
  String? currencyName;
  int? currencyId;

  CountryModel(
      {this.name,
        this.id,
        this.lang,
        this.callingCode,
        this.currencyName,
        this.currencyId});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    lang = json['lang'];
    callingCode = json['calling_code'];
    currencyName = json['currency_name'];
    currencyId = json['currency_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['lang'] = lang;
    data['calling_code'] = callingCode;
    data['currency_name'] = currencyName;
    data['currency_id'] = currencyId;
    return data;
  }
}
