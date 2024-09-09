import 'package:pmr_doctor_app/config/server.dart';
import 'package:pmr_doctor_app/model/login_model.dart';
import 'package:pmr_doctor_app/service/network_service.dart';

class LoginApiService{

  Future<LoginModel?> login(Map<String, dynamic> params) async {
    var response = await NetworkService().networkRequest(
        url: Server.LOGIN_URL, body: params, requestType: RequestType.POST);

    if (response != null) {
      return LoginModel.fromJson(response);
    }
    return null;
  }
}