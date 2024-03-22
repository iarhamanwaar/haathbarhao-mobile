import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../gen/colors.gen.dart';

class EmailField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  final String text;

  const EmailField({
    required this.textEditingController,
    required this.text,
    super.key,
  });

  @override
  ConsumerState createState() => _EmailFieldState();
}

class _EmailFieldState extends ConsumerState<EmailField> {
  bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  @override
  void initState() {
    widget.textEditingController.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.spaceGrotesk(
      fontSize: 16 / MediaQuery.textScalerOf(context).scale(1),
      fontWeight: FontWeight.w500,
      color: ColorName.black,
    );

    final labelStyle = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w500,
      fontSize: 12 / MediaQuery.textScalerOf(context).scale(1),
      color: const Color(0xFFB8B8B8),
    );

    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: widget.textEditingController,
        cursorColor: ColorName.primary,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        style: textStyle,
        validator: (value) {
          if (value != null) {
            return isValidEmail(value) ? null : 'Enter a valid email';
          }

          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 19,
          ),
          filled: true,
          fillColor: const Color(0xFF929292).withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: ColorName.primary,
            ),
          ),
          labelText: 'Email',
          labelStyle: labelStyle,
        ),
      ),
    );
  }
}
