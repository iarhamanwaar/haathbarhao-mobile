import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';

class PrimaryButton extends ConsumerStatefulWidget {
  final Function()? onPressed;
  final bool enabled;
  final String text;
  final bool invertColors;
  final bool isLoading;
  final Color? backgroundColor;
  final double? fontSize;

  const PrimaryButton({
    this.onPressed,
    required this.text,
    this.enabled = true,
    this.invertColors = false,
    this.isLoading = false,
    this.backgroundColor,
    this.fontSize = 20,
    super.key,
  });

  @override
  ConsumerState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends ConsumerState<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          disabledBackgroundColor: ColorName.grey,
          backgroundColor: widget.backgroundColor ??
              (widget.invertColors ? ColorName.primary : ColorName.white),
          shape: const StadiumBorder(),
          padding: EdgeInsets.zero,
        ),
        child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorName.white,
                  ),
                ),
              )
            : Text(
                widget.text,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w700,
                  color:
                      widget.invertColors ? ColorName.white : ColorName.primary,
                ),
              ),
      ),
    );
  }
}
