import 'package:pmr_doctor_app/config/server.dart';
import 'package:pmr_doctor_app/model/provider_list_model.dart';
import 'package:pmr_doctor_app/service/network_service.dart';

class ProviderListApiService{
  Future<ProviderListModel?> getProviderList() async {
    var response = await NetworkService().networkRequest(
        url: Server.PROVIDER_LIST_URL, requestType: RequestType.GET);

    if (response != null) {
      return ProviderListModel.fromJson(response);
    }
    return null;
  }
}