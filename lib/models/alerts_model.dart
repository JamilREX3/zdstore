

class AlertsReq {
  String? status;
  List<AlertModel>? alertsList;

  AlertsReq({this.status, this.alertsList});

  AlertsReq.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      alertsList = <AlertModel>[];
      json['data'].forEach((v) {
        alertsList!.add(AlertModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (alertsList != null) {
      data['data'] = alertsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlertModel {
  int? id;
  String? body;
  String? users;
  String? endedAt;
  String? createdAt;
  String? updatedAt;

  AlertModel(
      {this.id,
        this.body,
        this.users,
        this.endedAt,
        this.createdAt,
        this.updatedAt});

  AlertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    users = json['users'];
    endedAt = json['ended_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['users'] = users;
    data['ended_at'] = endedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
