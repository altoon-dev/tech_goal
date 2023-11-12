import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
     this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: suffixIcon != null ? InkWell(
              onTap: onSuffixIconPressed,
              child: suffixIcon,
            ) : null,
            hintStyle: const TextStyle(fontSize: 16),
            errorStyle: const TextStyle(height: 0.001),
            alignLabelWithHint: true,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
