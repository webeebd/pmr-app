import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';
import 'package:pmr_doctor_app/view/add_patient/add_patient_view_controller.dart';
import 'package:pmr_doctor_app/widgets/button/custom_elevated_button.dart';
import 'package:pmr_doctor_app/widgets/dialog/alert_custom_dialog.dart';
import 'package:pmr_doctor_app/widgets/drop_down/my_dropdown_button.dart';
import 'package:pmr_doctor_app/widgets/input/date_picker_field.dart';
import 'package:pmr_doctor_app/widgets/input/my_textfield.dart';
import 'package:pmr_doctor_app/widgets/ui_helper/ui_helper.dart';

class AddPatientView extends StatelessWidget {
  final _controller = Get.put(AddPatientViewController());
  AddPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title:Text(
            "Add Patient",
            style: TextStyle(
                color: ColorUtils.focusedColor,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16,),
                UIHelper().columTitleWithWidget(
                    title: "First Name *",
                    widget: MyTextField(
                      textEditingController: _controller.firstName,hintText: "First Name",)),
                UIHelper().columTitleWithWidget(
                    title: "Last Name *",
                    widget: MyTextField(
                      textEditingController: _controller.lastName,hintText: "Last Name",)),
                UIHelper().columTitleWithWidget(
                    title: "Gender",
                    widget: MyDropdownButton(value: _controller.selectedGender.value,
                        items: _controller.genderList,
                        hint: "Select Gender",
                        onChanged: (value){
                      _controller.selectedGender.value = value;
                        })),
                Obx(() => DatePickerField(
                    pickedDate: _controller.dateOfBirth.value,
                    title: 'Date of Birth',
                    callback: (value) {
                      _controller.dateOfBirth.value = value;
                    })),
                Obx(() => DatePickerField(
                    pickedDate: _controller.dateOfAccident.value,
                    title: 'Date of Accident',
                    callback: (value) {
                      _controller.dateOfAccident.value = value;
                    })),
                UIHelper().columTitleWithWidget(
                    title: "Claim Type",
                    widget: MyDropdownButton(
                        value: _controller.selectedClaimType.value,
                        items: _controller.claimTypeList,
                        hint: "Select Claim Type",
                        onChanged: (value){
                          _controller.selectedClaimType.value = value;
                        })),
                const SizedBox(height: 32,),
                Padding(
                  padding: const EdgeInsets.only( bottom: 48.0),
                  child: CustomElevatedButton(
                    text: "Save",
                    borderRadius: 12.0,
                    onPressed: (){
                      if(_controller.checkform()){
                        _controller.addPatient();
                      }else{
                        AlertCustomDialogs().showAlert(
                            msg: "Please select required field");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
