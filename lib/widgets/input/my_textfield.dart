import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final Function? onChanged;
  final Function? onSubmitted;
  bool isobscureText;
  final Function? isPasswordObscure;
  final bool isPassword;
  Widget? suffixIcon;
  Widget? prefixIcon;

  MyTextField(
      {super.key,
        required this.textEditingController,
        this.hintText = '',
        this.keyBoardType = TextInputType.text,
        this.onChanged,
        this.textInputAction = TextInputAction.next,
        this.onSubmitted,
        this.prefixIcon,
        this.suffixIcon,
        this.isPasswordObscure,
        this.isobscureText = false,
        this.isPassword = false
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isobscureText,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      onSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted!(value);
        }
      },
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        prefixIcon: prefixIcon,
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.focused)
            ? Colors.black
            : Colors.grey),
        suffixIcon:  isPassword
            ? GestureDetector(
          onTap: () {
            isobscureText = !isobscureText;
            isPasswordObscure!(isobscureText);
          },
          child: Icon(
              isobscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
              size: 18),
        )
            : suffixIcon,
        suffixIconColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.focused)
            ? Colors.black
            : Colors.grey),
        hintStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      keyboardType: keyBoardType,
      textInputAction: textInputAction,
    );
  }
}
