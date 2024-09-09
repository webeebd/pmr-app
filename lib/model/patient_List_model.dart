// To parse this JSON data, do
//
//     final patientListModel = patientListModelFromJson(jsonString);

import 'dart:convert';

PatientListModel patientListModelFromJson(String str) => PatientListModel.fromJson(json.decode(str));

String patientListModelToJson(PatientListModel data) => json.encode(data.toJson());

class PatientListModel {
  List<Datum>? data;

  PatientListModel({
    this.data,
  });

  factory PatientListModel.fromJson(Map<String, dynamic> json) => PatientListModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? userId;
  String? name;
  int? canAddPatient;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Patient>? patients;

  Datum({
    this.id,
    this.userId,
    this.name,
    this.canAddPatient,
    this.createdAt,
    this.updatedAt,
    this.patients,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    canAddPatient: json["can_add_patient"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    patients: json["patients"] == null ? [] : List<Patient>.from(json["patients"]!.map((x) => Patient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "can_add_patient": canAddPatient,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "patients": patients == null ? [] : List<dynamic>.from(patients!.map((x) => x.toJson())),
  };
}

class Patient {
  int? id;
  int? providerId;
  String? firstName;
  String? lastName;
  Gender? gender;
  DateTime? dob;
  DateTime? doa;
  String? claimType;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? laravelThroughKey;

  Patient({
    this.id,
    this.providerId,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.doa,
    this.claimType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.laravelThroughKey,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    providerId: json["provider_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"] == null ? null : genderValues.map[json["gender"]],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    doa: json["doa"] == null ? null : DateTime.parse(json["doa"]),
    claimType: json["claim_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    laravelThroughKey: json["laravel_through_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "first_name": firstName,
    "last_name": lastName,
    "gender": genderValues.reverse[gender],
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "doa": "${doa!.year.toString().padLeft(4, '0')}-${doa!.month.toString().padLeft(2, '0')}-${doa!.day.toString().padLeft(2, '0')}",
    "claim_type": claimType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "laravel_through_key": laravelThroughKey,
  };
}

enum Gender {
  FEMALE,
  MALE,
  N_A,
  Subbed
}

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "N/A": Gender.N_A
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
