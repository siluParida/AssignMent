import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/app_values.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextfield extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final Widget? SuffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  const CommonTextfield({
    super.key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.SuffixIcon,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText ?? false,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: maxLength != null ? [LengthLimitingTextInputFormatter(maxLength)] : [],
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: AppSize.s12, color: Colors.grey),
          labelStyle: TextStyle(fontSize: AppSize.s15, fontWeight: FontWeight.bold),
          suffixIcon: SuffixIcon,
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          errorStyle: TextStyle(fontSize: AppSize.s15, color: Colors.red),
        ),
      ),
    );
  }
}
