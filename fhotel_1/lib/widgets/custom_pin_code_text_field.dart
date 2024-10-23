import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField(
      {Key? key,
      required this.context,
      required this.onChanged,
      this.alignment,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.validator})
      : super(
          key: key,
        );
  final Alignment? alignment;
  final BuildContext context;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  Function(String) onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget)
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 5,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? CustomTextStyles.bodyMediumPrimary,
        hintStyle: hintStyle ?? CustomTextStyles.bodyMediumPrimary,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 48.h,
          fieldWidth: 48.h,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(4.h),
          inactiveColor: appTheme.yellow700,
          inactiveFillColor: appTheme.whiteA700,
          activeColor: appTheme.yellow700,
          activeFillColor: appTheme.whiteA700,
          selectedFillColor: appTheme.whiteA700,
          selectedColor: appTheme.yellow700,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
