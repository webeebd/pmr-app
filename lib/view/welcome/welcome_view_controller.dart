import 'package:get/get.dart';
import 'package:pmr_doctor_app/config/shared_preferences_manager.dart';
import 'package:pmr_doctor_app/utils/preference_keys.dart';
import 'package:pmr_doctor_app/view/login/login_view.dart';

class WelcomeViewController extends GetxController{

  void setupValidation(){
    SharedPreferencesManager.shared.setPrefBool(PreferenceKeys.isShowOnboarding, false);
    Get.off(() => LoginView());
  }

}