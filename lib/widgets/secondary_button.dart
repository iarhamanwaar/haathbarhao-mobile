import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../gen/colors.gen.dart';
import '../gen/fonts.gen.dart';

class SecondaryButton extends ConsumerWidget {
  final String text;
  final TextStyle textStyle;
  final Function()? onPressed;
  final bool outlined;
  final double width;
  final double height;

  const SecondaryButton({
    required this.text,
    required this.onPressed,
    this.textStyle = const TextStyle(
      fontFamily: FontFamily.clashDisplay,
      color: ColorName.white,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    this.width = double.infinity,
    this.height = 56,
    this.outlined = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: outlined
              ? BorderSide(
                  color: ColorName.black.withOpacity(0.1),
                  width: 0.5,
                )
              : BorderSide.none,
          backgroundColor: onPressed == null
              ? ColorName.black.withOpacity(0.1)
              : outlined
                  ? ColorName.white
                  : ColorName.primary,
          foregroundColor: outlined ? ColorName.primary : ColorName.white,
          elevation: 0,
          shape: const StadiumBorder(),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
