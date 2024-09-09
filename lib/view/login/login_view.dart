import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';
import 'package:pmr_doctor_app/view/login/login_view_controller.dart';
import 'package:pmr_doctor_app/widgets/button/custom_elevated_button.dart';
import 'package:pmr_doctor_app/widgets/dialog/alert_custom_dialog.dart';
import 'package:pmr_doctor_app/widgets/input/my_textfield.dart';
import 'package:pmr_doctor_app/widgets/ui_helper/ui_helper.dart';

class LoginView extends StatelessWidget {
  final _controller = Get.put(LoginViewController());
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/login_view_image.png",
                scale: 1.25,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 5,
                        width: 80,
                        color: ColorUtils.buttonColor,
                      ),
                      const SizedBox(height: 40),
                      UIHelper().columTitleWithWidget(
                          title: "UserName",
                          widget: MyTextField(
                            textEditingController: _controller.userName,
                            suffixIcon: const Icon(
                              Icons.people_alt_rounded,
                            ),
                            hintText: "username",
                          )),
                      UIHelper().columTitleWithWidget(
                          title: "Password",
                          widget: Obx(() => MyTextField(
                                textEditingController: _controller.password,
                                textInputAction: TextInputAction.done,
                                hintText: "password",
                                isPassword: true,
                                isobscureText:
                                    _controller.isPasswordHidden.value,
                                isPasswordObscure: (value) {
                                  _controller.isPasswordHidden.value = value;
                                },
                              ))),
                      const SizedBox(
                        height: 45,
                      ),
                      CustomElevatedButton(
                        text: "Login",
                        onPressed: (){
                          if(_controller.checkForm()){
                            _controller.login();
                          }else{
                            AlertCustomDialogs().showAlert(msg: "Please Select All Fields");
                          }
                        },
                        fontSize: 22,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
