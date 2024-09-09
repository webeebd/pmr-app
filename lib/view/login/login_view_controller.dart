import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/config/shared_preferences_manager.dart';
import 'package:pmr_doctor_app/data/login_api_service.dart';
import 'package:pmr_doctor_app/utils/app_string.dart';
import 'package:pmr_doctor_app/utils/preference_keys.dart';
import 'package:pmr_doctor_app/view/dashboard/dashboard_view.dart';
import 'package:pmr_doctor_app/widgets/dialog/alert_custom_dialog.dart';

class LoginViewController extends GetxController{
  final userName = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordHidden = RxBool(true);

  void login() async{
    Map<String, dynamic> params = {
      'username': userName.text,
      'password': password.text,
    };
    EasyLoading.show(status: 'Loading...');
    var result = await LoginApiService().login(params);
    if(result != null){
      if(result.status == status.success.name){
        await SharedPreferencesManager.shared.setPrefString(PreferenceKeys.accessToken, result.accessToken);
        Get.off(() => DashboardView());
      }else {
        AlertCustomDialogs().showError(
            msg: result.message!);
      }
    } else {
      AlertCustomDialogs().showError(msg: AppString.serverError);
    }
    EasyLoading.dismiss();
  }
  bool checkForm(){
    if(userName.text.isNotEmpty && password.text.isNotEmpty){
      return true;
    }
    return false;
  }

}