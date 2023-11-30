import 'package:flutter/material.dart';
import 'package:imcn3/utils/constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.initialValue,
  });

  final TextInputType? keyboardType;
  final String hintText;
  final bool? obscureText;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
      ),
      initialValue: initialValue,
      textAlign: TextAlign.center,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }
}