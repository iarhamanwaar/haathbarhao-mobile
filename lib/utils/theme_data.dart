import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';

final themeData = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: ColorName.primary,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorName.primary,
    ),
  ),
);
