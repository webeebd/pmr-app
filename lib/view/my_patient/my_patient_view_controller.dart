import 'package:get/get.dart';

class MyPatientViewController extends GetxController{
  List<String> patientNameList = [];
  int? providerId ;

  // Filtered list of patients (Reactive)
  RxList<String> filteredPatients = RxList<String>([]);

  @override
  void onInit() {
    if(Get.arguments != null){
      patientNameList = Get.arguments[0];
      providerId = Get.arguments[1];
    }
    filteredPatients.value = patientNameList;
    super.onInit();
  }

  // Function to filter the list based on search input
  void filterPatients(String query) {
    final filtered = patientNameList.where((patientName) {
      final nameLower = patientName.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
    filteredPatients.value = filtered;
  }

}