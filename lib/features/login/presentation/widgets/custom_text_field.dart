import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.isPassword = false,
    this.isEmail = false,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool isPassword;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: false,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: isPassword ? Icon(CupertinoIcons.eye) : SizedBox.shrink(),
      ),
    );
  }
}
