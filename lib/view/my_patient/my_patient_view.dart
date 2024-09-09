import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';
import 'package:pmr_doctor_app/view/add_patient/add_patient_view.dart';
import 'package:pmr_doctor_app/view/recording/recording_view.dart';

import 'my_patient_view_controller.dart';

class MyPatientView extends StatelessWidget {
  final MyPatientViewController _controller = Get.put(MyPatientViewController());

   MyPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Patient'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: ColorUtils.appBarColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(20.r),
              ),
              height: 60.h,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (query) {
                    _controller.filterPatients(query);
                  } ,
                  decoration: InputDecoration(
                    hintText: 'Search Patient',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Patient List
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: _controller.filteredPatients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.pink.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      onTap: (){
                        Get.to(()=> RecordingView());
                      },
                      title: Text(
                        _controller.filteredPatients[index],
                      ),
                      // subtitle: Text('${patient['id']} \n${patient['doctor']}'),
                      // isThreeLine: true,
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorUtils.buttonColor,
        onPressed: () {
          Get.to(()=> AddPatientView(),arguments: _controller.providerId);
        },
        label: const Text("Add Patient"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
