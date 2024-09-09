import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';

import 'recording_history_view_controller.dart';


class RecordingHistoryView extends StatelessWidget {
  final RecordingHistoryViewController controller = Get.put(RecordingHistoryViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Recording list',
          style: TextStyle(
            color: Colors.brown.shade700,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.brown.shade700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 10.h),
                // Recording List
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.recordings.length,
                      itemBuilder: (context, index) {
                        final recording = controller.recordings[index];
                        return Card(
                          color: Colors.pink.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: ListTile(
                            title: Text(
                              recording['name']!,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(recording['date']!),
                            trailing: IconButton(
                              onPressed: () {
                                _showDeleteConfirmationDialog(context, index);
                              },
                              icon: Center(
                                child: Icon(
                                  Icons.more_horiz,
                                  color: ColorUtils.buttonColor,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
            // Positioned(
            //   bottom: 30.h, // Adjust this value to move the FAB up
            //   right: 16.w,  // Maintain right alignment
            //   child: FloatingActionButton.extended(
            //     backgroundColor: ColorUtils.buttonColor,
            //     onPressed: () {
            //       // Add functionality for the recording button here
            //     },
            //     label: Text("Recording"),
            //     icon: Icon(Icons.mic),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            height: 220.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delete Recording?',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Are you sure you want to delete this recording? This action cannot be undone.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      onPressed: () {
                        controller.deleteRecording(index);
                        Get.back(); // Close the dialog after deletion
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
