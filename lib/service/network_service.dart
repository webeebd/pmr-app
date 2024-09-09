import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pmr_doctor_app/config/server.dart';
import 'package:pmr_doctor_app/config/shared_preferences_manager.dart';
import 'get_network_config.dart'
    if (dart.library.io) 'mobile_network_config.dart';

enum RequestType { GET, POST }

class NetworkService {
  final dio = createDio();
  NetworkService._internal();
  static final _apiService = NetworkService._internal();
  factory NetworkService() => _apiService;
  static Dio createDio() {
    Dio dio = getClient()
      ..options = BaseOptions(
        baseUrl: Server.BASE_URL,
        followRedirects: false,
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );

    dio.interceptors
        .addAll([AuthInterceptor(dio), Logging(dio), ErrorInterceptors(dio)]);
    return dio;
  }

  Future<dynamic> networkRequest(
      {Map<String, String>? head,
      required String url,
      Map<String, dynamic>? queryParameters,
      Object? body,
      required RequestType requestType,
      ResponseType? responseType,
      bool showProgress = false,
      Function(double)? getPercentage}) async {
    Response? result;
    try {
      switch (requestType) {
        case RequestType.GET:
          {
            Options options =
                Options(headers: head , responseType: responseType);
            result = await dio.get(url,
                queryParameters: queryParameters, options: options);
            break;
          }
        case RequestType.POST:
          {
            Options options =
                Options(headers: head , responseType: responseType);
            result = await dio.post(
              url,
              queryParameters: queryParameters,
              data: body,
              options: options,
              onSendProgress: (int sent, int total) {
                if (showProgress) {
                  double percent = (sent / total);
                  getPercentage!(percent);
                }
              },
            );
            break;
          }
      }
      return result.data;
    } on DioException catch (error) {
      showLog('My error stacktrace: ${error.stackTrace}');
      return showLog(
          'Dio Error Type: ${error.type}, Error: ${error.error ?? 'Null'}, Message: ${error.message ?? 'Null'}');
    } catch (error) {
      return log(error.toString());
    }
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;
  AuthInterceptor(this.dio);
  String? accessToken;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    accessToken = await SharedPreferencesManager.shared.getPrefString("accessToken");

    if (accessToken != null &&
        accessToken != '' &&
        options.path.contains(options.baseUrl)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}

class Logging extends Interceptor {
  final Dio dio;

  Logging(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    showLog(
        'REQUEST[${options.method}] => PATH: ${options.path} \n Extras: ${options.extra} \n Headers: ${options.headers} \n Query: ${options.queryParameters} \n Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    showLog(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} \n res:: ${json.encode(response.data)}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    showLog(
        'ERROR[${err.response!.statusCode ?? 'Unknown Status Code'}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

class ErrorInterceptors extends Interceptor {
  final Dio dio;

  ErrorInterceptors(this.dio);

  bool isLoggedOut = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}

void showLog(String msg) {
    log(msg);
}

