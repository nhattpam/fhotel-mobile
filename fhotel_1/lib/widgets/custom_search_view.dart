import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.boxDecoration,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
    this.onSubmitted, // Add onSubmitted parameter
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted; // Add onSubmitted

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: searchViewWidget(context),
    )
        : searchViewWidget(context);
  }

  Widget searchViewWidget(BuildContext context) => Container(
    width: width ?? double.maxFinite,
    decoration: boxDecoration,
    child: TextFormField(
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        controller: controller,
        focusNode: focusNode,
        onTapOutside: (event) {
          if (focusNode != null) {
            focusNode?.unfocus();
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        autofocus: autofocus!,
        style: textStyle ?? theme.textTheme.bodyMedium,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: decoration,
        validator: validator,
        onChanged: (String value) {
          onChanged?.call(value);
        },
        onFieldSubmitted: (String value) {
          onSubmitted?.call(value); // Trigger onSubmitted when "Enter" is pressed
        }),
  );

  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle ?? CustomTextStyles.bodyMediumGray600,
    prefixIcon: prefix ??
        Container(
          margin: EdgeInsets.fromLTRB(32.h, 16.h, 6.h, 16.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgSearch,
            height: 24.h,
            width: 24.h,
          ),
        ),
    prefixIconConstraints: prefixConstraints ??
        BoxConstraints(
          maxHeight: 56.h,
        ),
    // suffixIcon: suffix ??
    //     Padding(
    //       padding: EdgeInsets.only(
    //         right: 15.h,
    //       ),
    //       child: IconButton(
    //         onPressed: () => controller!.clear(),
    //         icon: Icon(
    //           Icons.clear,
    //           color: Colors.grey.shade600,
    //         ),
    //       ),
    //     ),
    // suffixIconConstraints: suffixConstraints ??
    //     BoxConstraints(
    //       maxHeight: 56.h,
    //     ),
    isDense: true,
    contentPadding:
    contentPadding ?? EdgeInsets.fromLTRB(16.h, 16.h, 12.h, 16.h),
    fillColor: fillColor ?? appTheme.whiteA700,
    filled: filled,
    border: borderDecoration ??
        OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
    focusedBorder: (borderDecoration ?? OutlineInputBorder()).copyWith(
      borderSide: BorderSide(
        color: theme.colorScheme.primary,
        width: 1,
      ),
    ),
  );
}
