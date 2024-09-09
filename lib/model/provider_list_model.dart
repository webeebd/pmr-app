// To parse this JSON data, do
//
//     final providerListModel = providerListModelFromJson(jsonString);

import 'dart:convert';

ProviderListModel providerListModelFromJson(String str) => ProviderListModel.fromJson(json.decode(str));

String providerListModelToJson(ProviderListModel data) => json.encode(data.toJson());

class ProviderListModel {
  List<Data>? data;

  ProviderListModel({
    this.data,
  });

  factory ProviderListModel.fromJson(Map<String, dynamic> json) => ProviderListModel(
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  int? id;
  int? userId;
  String? name;
  int? canAddPatient;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Provider>? providers;

  Data({
    this.id,
    this.userId,
    this.name,
    this.canAddPatient,
    this.createdAt,
    this.updatedAt,
    this.providers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    canAddPatient: json["can_add_patient"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    providers: json["providers"] == null ? [] : List<Provider>.from(json["providers"]!.map((x) => Provider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "can_add_patient": canAddPatient,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "providers": providers == null ? [] : List<dynamic>.from(providers!.map((x) => x.toJson())),
  };
}

class Provider {
  int? id;
  int? userId;
  String? name;
  int? canAddDoctor;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? laravelThroughKey;

  Provider({
    this.id,
    this.userId,
    this.name,
    this.canAddDoctor,
    this.createdAt,
    this.updatedAt,
    this.laravelThroughKey,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    canAddDoctor: json["can_add_doctor"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    laravelThroughKey: json["laravel_through_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "can_add_doctor": canAddDoctor,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "laravel_through_key": laravelThroughKey,
  };
}
