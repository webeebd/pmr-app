import 'package:flutter/material.dart';
import 'package:pmr_doctor_app/utils/DateFun.dart';

class DatePickerField extends StatelessWidget {
  final String title;
  final String? pickedDate;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final Function(String) callback;

  const DatePickerField(
      {super.key,
      required this.pickedDate,
      required this.title,
      this.firstDate,
      this.lastDate,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    // final dtNow = DateTime.now();
    // final currentDT = DateTime(dtNow.year - 18, dtNow.month, dtNow.day);
    DateTime? initialDate;
    if (pickedDate != null && pickedDate!.isNotEmpty) {
      initialDate = DateFun.convertToDateTime(pickedDate!, 'dd-MMM-yyyy');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: initialDate ?? DateTime.now(),
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: lastDate ?? DateTime.now())
                .then((value) {
              if (value != null) {
                callback(DateFun.getStringFromDateTime(value));
              }
            });
          },
          // child: FakeInputField(
          //   text: initialDate != null ? pickedDate! : 'Enter date',
          //   icon: showDateIcon ? Icons.calendar_today_outlined : null,
          //   isHint: initialDate == null,
          // ),
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(initialDate != null ? pickedDate! : 'Enter date',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              initialDate == null ? Colors.grey : Colors.black))
                ],
              )),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
