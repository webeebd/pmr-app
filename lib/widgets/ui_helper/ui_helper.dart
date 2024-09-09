import 'package:flutter/material.dart';

class UIHelper{
  Widget columTitleWithWidget(
      {required String title, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        const SizedBox(height: 8),
        widget,
        const SizedBox(height: 16),
      ],
    );
  }
}