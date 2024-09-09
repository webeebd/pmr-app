import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';
import 'package:pmr_doctor_app/view/welcome/welcome_view_controller.dart';
import 'package:pmr_doctor_app/widgets/button/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeView extends StatelessWidget {
  final _controller = Get.put(WelcomeViewController());
   WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 50.h),
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'assets/logo/welcome_view_logo.png',
                  height: 514.h,
                  width: double.maxFinite,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                            color: ColorUtils.appBarColor,
                            fontWeight: FontWeight.bold,fontSize: 35.sp),
                      ),
                      Container(
                        width: 190.h,
                        margin: EdgeInsets.only(left: 8.h),
                        child: Text(
                          "we're glad that you are here..!!",maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ColorUtils.appBarColor,fontSize: 16,fontStyle: FontStyle.italic),
                        ),
                      ),
                      Spacer(),

                      Center(
                        child: SizedBox(
                          width: 150.w,
                          height: 40.h,
                          child: CustomElevatedButton(
                              text: "Let's Start",
                          onPressed: _controller.setupValidation,
                          ),
                        ),
                      ),
                      SizedBox(height: 55.h,),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 12.h,
                          child: AnimatedSmoothIndicator(
                            activeIndex: 0,
                            count: 2,
                            effect: ScrollingDotsEffect(
                              spacing: 10,
                              activeDotColor: ColorUtils.buttonColor,
                              dotColor: ColorUtils.buttonColor2,
                              dotHeight: 12.h,
                              dotWidth: 34.h,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//child: Image.asset('assets/logo/welcome_view_logo.png')
