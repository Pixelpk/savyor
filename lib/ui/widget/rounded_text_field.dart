import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';

import '../../constant/style.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final bool readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxDecoration? decoration;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const RoundedTextField(
      {required this.hintText,
      this.obscureText,
      this.controller,
      this.decoration,
      this.suffixIcon,
      this.readOnly = false,
      this.onChanged,
      this.validator,
      this.onTap,
      this.keyboardType,
      this.textInputAction,
      this.focusNode,
      this.prefixIcon,
      this.prefixIconConstraints,
      this.suffixIconConstraints,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        autocorrect: false,
        style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            prefixIconConstraints: prefixIconConstraints,
            suffixIconConstraints: suffixIconConstraints,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: context.textTheme.subtitle2
                ?.copyWith(color: Style.textHintColor, fontWeight: FontWeight.normal, fontFamily: 'DM Sans'),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Colors.redAccent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Style.unSelectedColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Style.unSelectedColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Style.unSelectedColor))));
  }
}
