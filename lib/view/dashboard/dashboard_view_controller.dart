import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/config/shared_preferences_manager.dart';
import 'package:pmr_doctor_app/data/patient_api_service.dart';
import 'package:pmr_doctor_app/data/provider_list_api_service.dart';
import 'package:pmr_doctor_app/model/patient_List_model.dart';
import 'package:pmr_doctor_app/model/provider_list_model.dart';
import 'package:pmr_doctor_app/utils/preference_keys.dart';
import 'package:pmr_doctor_app/view/login/login_view.dart';
import 'package:pmr_doctor_app/widgets/dialog/alert_custom_dialog.dart';

class DashboardViewController extends GetxController{
List<Provider> providerList = [];
List<String> providerNameList = [];
int providerId = 0;
List<Patient> patientList = [];
RxList<String> patientNameList = RxList([]);
RxString doctorName = RxString("");
RxBool isLoading = RxBool(false);
RxBool isPatientLoading = RxBool(false);
RxnString selectedProvider = RxnString();

@override
  void onInit() {
  getProviderList();
    super.onInit();
  }
void logout() async{
  SharedPreferencesManager.shared.removePref(PreferenceKeys.accessToken);
  Get.off(() => LoginView());
}
void getProviderList() async{
  EasyLoading.show(status: 'Loading...');
  var result = await ProviderListApiService().getProviderList();
  if(result != null){
     providerList = result.data![0].providers!;
     doctorName.value = result.data![0].name!;
      for (var value in providerList) {
        providerNameList.add(value.name!);
      }
  }else{
    AlertCustomDialogs().showError(msg: "Can't Load Providers");
  }
  EasyLoading.dismiss();
  isLoading.value = true;
}

 void findProviderId(){
   patientNameList.clear();
  for (var value in providerList) {
    if(selectedProvider.value == value.name){
      providerId = value.userId!;
    }
  }
}

void getPatientList(int providerId) async{
  isPatientLoading.value = true;
  var result = await PatientApiService().getPatientList();
  if(result != null){
    patientList = result.data![0].patients!;
    for (var value in patientList) {
      if(providerId == value.providerId){
        patientNameList.add("${value.firstName!} ${value.lastName}" );
      }
    }
    isPatientLoading.value = false;
  }else{
    AlertCustomDialogs().showError(msg: "Can't Load Patients");
  }
}
}