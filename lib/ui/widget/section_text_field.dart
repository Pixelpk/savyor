import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';

class SectionTextField extends BaseStateLessWidget {
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

  SectionTextField(
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
        style: context.textTheme.subtitle1
            ?.copyWith(color: Style.textColor, fontWeight: FontWeight.normal, fontFamily: 'DM Sans'),
        decoration: InputDecoration(
            prefixIcon: Padding(padding: const EdgeInsets.only(right: 10), child: prefixIcon),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            prefixIconConstraints: prefixIconConstraints,
            suffixIconConstraints: suffixIconConstraints,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: context.textTheme.subtitle2
                ?.copyWith(color: Style.textHintColor, fontWeight: FontWeight.normal, fontFamily: 'DM Sans'),
            errorBorder: kUnderLineInputBorder(),
            enabledBorder: kUnderLineInputBorder(),
            focusedBorder: kUnderLineInputBorder(),
            border: kUnderLineInputBorder()));
  }

  static kUnderLineInputBorder() => const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff000000)));
}
