import 'package:get/get.dart';

class RecordingHistoryViewController extends GetxController{

  // List of recordings
  var recordings = <Map<String, String>>[
    {"name": "Wade Warren", "date": "19 Jan 2024"},
    {"name": "Louis Winget", "date": "19 Jan 2024"},
    {"name": "Jennifer Winget", "date": "19 Jan 2024"},
    {"name": "Mariam Sharma", "date": "19 Jan 2024"},
  ].obs;

  // Function to delete recording
  void deleteRecording(int index) {
    recordings.removeAt(index);
    Get.snackbar('Deleted', 'Recording deleted', duration: Duration(seconds: 2));
  }

}