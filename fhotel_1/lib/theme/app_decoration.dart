import 'package:flutter/material.dart';
import 'package:fhotel_1/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get aliasOutlineVariant => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.blueGray50,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.03),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          )
        ],
      );

  static BoxDecoration get aliasTheme => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get aliasThemeVariant => BoxDecoration(
        color: appTheme.gray10001,
      );

// Button decorations
  static BoxDecoration get buttonBrandOutlinedBorderDefault => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );

  static BoxDecoration get buttonBrandOutlinedBorderDisabled => BoxDecoration(
        border: Border.all(
          color: appTheme.black900.withOpacity(0.05),
          width: 1.h,
        ),
      );

  static BoxDecoration get buttonBrandSolidBackgroundDefault => BoxDecoration(
        color: theme.colorScheme.primary,
      );

// Chip decorations
  static BoxDecoration get chipBorderDefault => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1.h,
        ),
      );

  static BoxDecoration get chipBorderDefaultChipBackgroundDefault =>
      BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1.h,
        ),
      );

  // Divider decorations
  static BoxDecoration get dividerThinBackgroundDefault => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
            bottom: BorderSide(
          color: appTheme.blueGray50,
          width: 1.h,
        )),
      );

  static BoxDecoration
      get dividerThinBackgroundDefaultButtonbarBackgroundDefault =>
          BoxDecoration(
            color: appTheme.whiteA700,
            border: Border(
              top: BorderSide(
                color: appTheme.blueGray50,
                width: 1.h,
              ),
            ),
          );

// Fill decorations
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
      );

// Global decorations
  static BoxDecoration get globalBlue10 => BoxDecoration(
        color: appTheme.gray100,
      );

// Gradient decorations
  static BoxDecoration get gradientBlackToBlack => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.black900.withOpacity(0.6),
            appTheme.black900.withOpacity(0.6)
          ],
        ),
      );

  static BoxDecoration get gradientVerticalBrand0Brand100 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            theme.colorScheme.primary.withOpacity(0),
            theme.colorScheme.primary
          ],
        ),
      );

  // Navigationbar decorations
  static BoxDecoration get navigationbarNavboxBackgroundOnDark => BoxDecoration(
        color: appTheme.black900.withOpacity(0.2),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        border: Border.all(
          color: appTheme.black900.withOpacity(0.1),
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineBluegray50 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineBluegray501 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineBluegray502 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineWhiteA => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border(
          top: BorderSide(
            color: appTheme.whiteA700.withOpacity(0.15),
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineWhiteA700 => BoxDecoration(
        color: appTheme.redA200,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 1.h,
        ),
      );

// Overlay decorations
  static BoxDecoration get overlayBackgroundSolid => BoxDecoration(
        color: appTheme.black900.withOpacity(0.4),
      );

// Section decorations
  static BoxDecoration get sectionBackgroundDefault => BoxDecoration(
        color: appTheme.whiteA700,
      );

//Tab decorations
  static BoxDecoration get tabBasicBorderActive => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get tabBasicBorderInactive => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      );

//Toast decorations
  static BoxDecoration get toastBackgroundNegative => BoxDecoration(
        color: appTheme.redA200,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              2,
            ),
          )
        ],
      );

  static BoxDecoration get toastBackgroundPositive => BoxDecoration(
        color: appTheme.greenA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              2,
            ),
          )
        ],
      );

}
class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius. circular(
    12.h,
  );
  static BorderRadius get circleBorder16 => BorderRadius.circular(
      16.h,
  );
// Custom borders
  static BorderRadius get customBorderTL16 => BorderRadius.vertical(
  top: Radius.circular(16.h),
  );
  static BorderRadius get customBorderTL8 => BorderRadius.vertical(
    top: Radius.circular(8.h),
  );
// Rounded borders
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
    4.h,
  );
  static BorderRadius get roundedBorder8 => BorderRadius. circular(
  8.h,
  );
}
