import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';

class AppDecoration {
  // B decorations
  static BoxDecoration get bg => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );

  // Fill decorations
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray50,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  // Primary decorations
  static BoxDecoration get primary => BoxDecoration(
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.errorContainer.withOpacity(0.14),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      );

  // White decorations
  static BoxDecoration get white => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primaryContainer,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get circleBorder51 => BorderRadius.circular(
        51.h,
      );
  static BorderRadius get circleBorder61 => BorderRadius.circular(
        61.h,
      );
  static BorderRadius get circleBorder64 => BorderRadius.circular(
        64.h,
      );
  static BorderRadius get circleBorder74 => BorderRadius.circular(
        74.h,
      );
  static BorderRadius get circleBorder91 => BorderRadius.circular(
        91.h,
      );
  static BorderRadius get circleBorder96 => BorderRadius.circular(
        96.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder33 => BorderRadius.circular(
        33.h,
      );
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );
  static BorderRadius get roundedBorder70 => BorderRadius.circular(
        70.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
