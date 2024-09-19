import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
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
    required this.context, // 1. Add BuildContext parameter
  }) : super(
          key: key,
        );

  final Alignment? alignment;
  final BuildContext context; // 2. Define BuildContext parameter

  final double? width;
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

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: searchViewWidget(context),
          )
        : searchViewWidget(context);
  }

  Widget searchViewWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          autofocus: false,
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          // autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.titleSmallGray600,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          // decoration: decoration,
          validator: validator,
          onTap: () {
            controller?.clear();
            // showSearch(context: context, delegate: SearchCourse());
          },
        ),
      );

  // InputDecoration get decoration => InputDecoration(
  //       hintText: hintText ?? "",
  //       hintStyle: hintStyle ?? CustomTextStyles.titleSmallGray600,
  //       isDense: true,
  //       contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 21.v),
  //       fillColor: fillColor ?? theme.colorScheme.onPrimaryContainer,
  //       filled: filled,
  //       border: borderDecoration ??
  //           OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.h),
  //             borderSide: BorderSide.none,
  //           ),
  //       enabledBorder: borderDecoration ??
  //           OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.h),
  //             borderSide: BorderSide.none,
  //           ),
  //       focusedBorder: borderDecoration ??
  //           OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.h),
  //             borderSide: BorderSide.none,
  //           ),
  //     );

}
