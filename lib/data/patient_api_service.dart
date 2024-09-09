import 'package:pmr_doctor_app/config/server.dart';
import 'package:pmr_doctor_app/model/patient_List_model.dart';
import 'package:pmr_doctor_app/service/network_service.dart';

class PatientApiService {
  Future<PatientListModel?> getPatientList() async {
    var response = await NetworkService().networkRequest(
        url: Server.PATIENT_LIST_URL, requestType: RequestType.GET);

    if (response != null) {
      return PatientListModel.fromJson(response);
    }
    return null;
  }

  dynamic addPatient(Map<String, dynamic> params) async {
    var response = await NetworkService().networkRequest(
        url: Server.ADD_PATIENT_URL, body: params, requestType: RequestType.POST);
    return response;
  }
}