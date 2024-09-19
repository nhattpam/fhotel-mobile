import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.h),
      );

  static BoxDecoration get fillBlackTL12 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.h),
      );

  static BoxDecoration get outlineBlack => BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.1),
          width: 1.h,
        ),
      );
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: appTheme.whiteA700.withOpacity(0.2),
                  width: 1.h,
                ),
              ),
          child: IconButton(
              padding: padding ?? EdgeInsets.zero,
              onPressed: onTap,
              icon: child ?? Container()),
        ),
      );
}
