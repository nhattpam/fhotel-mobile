import 'package:flutter/material.dart';
import 'package:fhotel_1/core/app_export.dart';
extension on TextStyle {

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
class CustomTextStyles {
// Body text style
  static get bodyLargeBlack900 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.15),
      );

  static get bodyLargeBlack900_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.15),
      );

  static get bodyLargeGray600 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray600,
      );

  static get bodyLargeOnPrimary =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get bodyLargeOnPrimary_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get bodyLargePrimary =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyMediumGray600 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray600,
      );

  static get bodyMediumPrimary =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyMediumRedA200 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.redA200,
      );

  static get bodyMediumRobotoWhiteA700 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.whiteA700,
        fontSize: 13.fSize,
      );

  static get bodyMediumSecondaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );

  static get bodyMediumTeal800 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.teal800,
      );

  static get bodyMediumwhiteA700 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  static get bodySmall10 =>
      theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );

  static get bodySmallBlack900 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );

  static get bodySmallOnPrimary =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 10.fSize,
      );

  static get bodySmallOnPrimary10 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 10.fSize,
      );

  static get bodySmallOnPrimary_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get bodySmallRedA200 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.redA200,
      );

  static get bodySmallWhiteA700 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
      );

  // Title text style
  static get titleMediumGreenA700 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.greenA700,
      );

  static get titleMediumRedA200 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.redA200,
      );

  static get titleMediumwhiteA700 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
      );

  static get titleSmallGray600 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray600,
      );

  static get titleSmallMedium =>
      theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );

  static get titleSmallPrimary =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get titleSmallPrimary_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get titleSmallRedA200 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.redA200,
      );

  static get titleSmallwhiteA700 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
}