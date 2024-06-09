import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';

final themeData = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: ColorName.primary,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: ColorName.transparentColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorName.primary,
    ),
  ),
);
