import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';
import 'package:pmr_doctor_app/view/splash/splash_view.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder:(context)=>const MyApp()
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.black
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorUtils.buttonColor
    ..maskColor = Colors.grey
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: false,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(),
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            home:  SplashView(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}