import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/view/splash/splash_view_controller.dart';

class SplashView extends StatelessWidget {
  final _controller = Get.put(SplashViewController());
    SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child:Image.asset('assets/logo/splash-logo.png'),
        ),
      ),
      ),
    );
  }
}
