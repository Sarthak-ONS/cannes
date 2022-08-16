import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, this.textEditingController, this.label, this.isObscure})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String? label;
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController!,
      maxLines: 1,
      obscureText: isObscure ?? false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        isCollapsed: false,
        isDense: true,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusColor: Colors.red,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label ?? 'Email',
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
