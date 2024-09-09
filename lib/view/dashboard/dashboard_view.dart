import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';
import 'package:pmr_doctor_app/view/add_patient/add_patient_view.dart';
import 'package:pmr_doctor_app/view/dashboard/dashboard_view_controller.dart';
import 'package:pmr_doctor_app/view/my_patient/my_patient_view.dart';
import 'package:pmr_doctor_app/view/recording_history/recording_history_view.dart';
import 'package:pmr_doctor_app/widgets/button/custom_elevated_button.dart';
import 'package:pmr_doctor_app/widgets/dialog/alert_custom_dialog.dart';
import 'package:pmr_doctor_app/widgets/drop_down/my_dropdown_button.dart';
import 'package:pmr_doctor_app/widgets/ui_helper/ui_helper.dart';

class DashboardView extends StatelessWidget {
  final _controller = Get.put(DashboardViewController());
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        actions: [
          IconButton(
              onPressed: () {
                _controller.logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.redAccent,
                size: 26,
              ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              text: "Add Patient",
              onPressed: () {
                if (_controller.selectedProvider.value != null) {
                  Get.to(() => AddPatientView(),
                      arguments: _controller.providerId);
                } else {
                  AlertCustomDialogs()
                      .showAlert(msg: "Please Select Provider at first");
                }
              },
              icon: Icons.add,
            ),
            // const SizedBox(width: 24,),
            const Spacer(),
            CustomElevatedButton(
              text: "Recording",
              onPressed: () {
                Get.to(() => MyPatientView(), arguments: [
                  _controller.patientNameList,
                  _controller.providerId
                ]);
              },
              icon: Icons.mic,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => _controller.isLoading.value
            ? Column(
                children: [
                  // Profile Picture
                  Center(
                    child: CircleAvatar(
                      radius: 80.r,
                      backgroundColor: ColorUtils.buttonColor,
                      child: CircleAvatar(
                        radius: 75.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundImage: const AssetImage(
                              'assets/images/dashboard_man_image.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Name and Designation
                  Text(
                    _controller.doctorName.value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.appBarColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: UIHelper().columTitleWithWidget(
                        title: "All Providers",
                        widget: MyDropdownButton(
                            value: _controller.selectedProvider.value,
                            items: _controller.providerNameList,
                            onChanged: (value) {
                              _controller.selectedProvider.value = value;
                              _controller.findProviderId();
                              _controller
                                  .getPatientList(_controller.providerId);
                            }),
                      )),
                  SizedBox(height: 24.h),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton(
                          showLoader: _controller.isPatientLoading.value,
                          text:
                              'My Patient\n${_controller.patientNameList.length}',
                          context: context,
                          onTab: () {
                            if (_controller.selectedProvider.value != null) {
                              Get.to(() => MyPatientView(), arguments: [
                                _controller.patientNameList,
                                _controller.providerId
                              ]);
                            } else {
                              AlertCustomDialogs().showAlert(
                                  msg: "Please Select Provider at first");
                            }
                          }),
                      _buildOptionButton(
                          text: 'Recording\n01',
                          context: context,
                          onTab: () {
                            Get.to(() => RecordingHistoryView());
                          }),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Recent Recordings Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Recent Recording',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.appBarColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Recent Recording Card
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.pink.shade50,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ListTile(
                        title: const Text('Wade Warren'),
                        subtitle: const Text('19 Jan 2024\nOlivia Mitchel'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Center(
                              child: Icon(
                            Icons.more_horiz,
                            color: ColorUtils.buttonColor,
                            size: 40,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      )),
    );
  }

  Widget _buildOptionButton(
      {required String text,
      required BuildContext context,
      required VoidCallback onTab,
      showLoader = false}) {
    return SizedBox(
      height: 55.h,
      width: 150.w,
      child: ElevatedButton(
        onPressed: onTab,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        child: showLoader
            ? const CircularProgressIndicator(
                color: Color(0xFFD74B3A),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
