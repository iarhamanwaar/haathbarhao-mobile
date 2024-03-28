import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTile extends ConsumerWidget {
  final Function() onPress;
  final String text;
  final Widget icon;
  final Widget trailingWidget;
  final Color color;

  const ProfileTile({
    required this.onPress,
    required this.text,
    required this.icon,
    required this.color,
    required this.trailingWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        backgroundColor: const Color(0xFF311237),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(
                width: 7,
              ),
              Text(
                text,
                textScaler: TextScaler.noScaling,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: color,
                ),
              ),
            ],
          ),
          trailingWidget,
        ],
      ),
    );
  }
}
