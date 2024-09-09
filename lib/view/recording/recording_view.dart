import 'package:flutter/material.dart';
import 'package:pmr_doctor_app/utils/color_utils.dart';

class RecordingView extends StatelessWidget {
    const RecordingView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Recording'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: ColorUtils.appBarColor, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.grey.shade700),
      ),
    );
  }
}
