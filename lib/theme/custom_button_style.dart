import 'package:haathbarhao_mobile/core/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillAmber => ElevatedButton.styleFrom(
        backgroundColor: appTheme.amber700,
      );
  static ButtonStyle get fillOnPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              35.h,
            ),
            topRight: Radius.circular(
              34.h,
            ),
            bottomLeft: Radius.circular(
              35.h,
            ),
            bottomRight: Radius.circular(
              34.h,
            ),
          ),
        ),
      );
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              35.h,
            ),
            topRight: Radius.circular(
              34.h,
            ),
            bottomLeft: Radius.circular(
              35.h,
            ),
            bottomRight: Radius.circular(
              34.h,
            ),
          ),
        ),
      );
  static ButtonStyle get fillPrimaryTL32 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.h),
        ),
      );
  static ButtonStyle get fillPrimaryTL38 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38.h),
        ),
      );
  static ButtonStyle get fillTeal => ElevatedButton.styleFrom(
        backgroundColor: appTheme.teal800,
      );

  // Outline button style
  static ButtonStyle get outlineErrorContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        shadowColor: theme.colorScheme.errorContainer,
        elevation: 4,
      );
  static ButtonStyle get outlineErrorContainerTL12 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        shadowColor: theme.colorScheme.errorContainer,
        elevation: 4,
      );
  static ButtonStyle get outlineErrorContainerTL121 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        shadowColor: theme.colorScheme.errorContainer.withOpacity(0.14),
        elevation: 4,
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
