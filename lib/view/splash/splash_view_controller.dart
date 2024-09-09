
import 'package:get/get.dart';
import 'package:pmr_doctor_app/config/shared_preferences_manager.dart';
import 'package:pmr_doctor_app/utils/preference_keys.dart';
import 'package:pmr_doctor_app/view/dashboard/dashboard_view.dart';
import 'package:pmr_doctor_app/view/login/login_view.dart';
import 'package:pmr_doctor_app/view/welcome/welcome_view.dart';

class SplashViewController extends GetxController{
@override
  void onInit() {
    appInit();
    super.onInit();
  }

  void appInit() async{
    await Future.delayed(const Duration(seconds: 2));
    if(!await SharedPreferencesManager.shared.getPrefBool(PreferenceKeys.isShowOnboarding)){
      if( await SharedPreferencesManager.shared.getPrefString(PreferenceKeys.accessToken) != null){
        Get.off(() => DashboardView());
      }else{
        Get.off(() => LoginView());
      }
    }else{
      Get.off(() => WelcomeView());
    }
  }
}