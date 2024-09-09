// To parse this JSON data, do
//
//     final addPatientModel = addPatientModelFromJson(jsonString);

import 'dart:convert';

AddPatientModel addPatientModelFromJson(String str) => AddPatientModel.fromJson(json.decode(str));

String addPatientModelToJson(AddPatientModel data) => json.encode(data.toJson());

class AddPatientModel {
  String? status;
  String? message;
  Patient? patient;

  AddPatientModel({
    this.status,
    this.message,
    this.patient,
  });

  factory AddPatientModel.fromJson(Map<String, dynamic> json) => AddPatientModel(
    status: json["status"],
    message: json["message"],
    patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "patient": patient?.toJson(),
  };
}

class Patient {
  String? firstName;
  String? lastName;
  String? providerId;
  DateTime? dob;
  DateTime? doa;
  String? gender;
  String? claimType;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Patient({
    this.firstName,
    this.lastName,
    this.providerId,
    this.dob,
    this.doa,
    this.gender,
    this.claimType,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    firstName: json["first_name"],
    lastName: json["last_name"],
    providerId: json["provider_id"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    doa: json["doa"] == null ? null : DateTime.parse(json["doa"]),
    gender: json["gender"],
    claimType: json["claim_type"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "provider_id": providerId,
    "dob": dob?.toIso8601String(),
    "doa": doa?.toIso8601String(),
    "gender": gender,
    "claim_type": claimType,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
