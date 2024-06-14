// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../gen/colors.gen.dart';

class NavBarItem extends ConsumerWidget {
  final int currentIndex;
  final int index;
  final String iconOutlined;
  final String iconFilled;
  final String label;
  final Function()? onTap;

  const NavBarItem({
    required this.currentIndex,
    required this.index,
    required this.iconOutlined,
    required this.iconFilled,
    required this.label,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (currentIndex == index) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: ColorName.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconFilled,
                color: ColorName.primary,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                label,
                textScaler: TextScaler.noScaling,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                  color: ColorName.primary,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 38,
          child: SvgPicture.asset(
            iconOutlined,
            color: ColorName.black,
          ),
        ),
      );
    }
  }
}
