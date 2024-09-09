import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/data/patient_api_service.dart';
import 'package:pmr_doctor_app/utils/DateFun.dart';
import 'package:pmr_doctor_app/utils/app_string.dart';
import 'package:pmr_doctor_app/widgets/dialog/alert_custom_dialog.dart';

class AddPatientViewController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  List genderList = ["Male", "Female", "Other"];
  RxnString selectedGender = RxnString();
  List claimTypeList = [
    "Workers Comp",
    "No Fault",
    "Labour Law",
    "Slip and Fall",
    "Subbed",
    "Lien"
  ];
  RxnString selectedClaimType = RxnString();
  RxnString dateOfBirth = RxnString();
  RxnString dateOfAccident = RxnString();
  final email = TextEditingController();
  int? providerId;
  @override
  void onInit() {
    if (Get.arguments != null) {
      providerId = Get.arguments;
    }
    super.onInit();
  }

  void addPatient() async {
    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> params = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      'gender': selectedGender.value,
      "dob": dateOfBirth.value == null
          ? null
          : DateFun.convertToDateTime(dateOfBirth.value!, 'dd-MMM-yyyy')
              .toString(),
      "doa": dateOfAccident.value == null
          ? null
          : DateFun.convertToDateTime(dateOfAccident.value!, 'dd-MMM-yyyy')
              .toString(),
      "provider_id": providerId,
      "claim_type": selectedClaimType.value
    };
    var result = await PatientApiService().addPatient(params);
    if (result != null) {
      if (result["status"] == status.success.name) {
        AlertCustomDialogs().showSuccess(msg: result["message"]);
        Get.back();
      } else {
        String messages = "";
        for (var msg in result["message"]) {
          messages = messages + " " + msg;
        }
        AlertCustomDialogs().showAlert(msg: messages);
      }
    }
    EasyLoading.dismiss();
  }

  bool checkform() {
    if (firstName.text.isNotEmpty && lastName.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
