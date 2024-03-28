import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';

class DobField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  final String text;

  const DobField({
    required this.textEditingController,
    required this.text,
    super.key,
  });

  @override
  ConsumerState createState() => _DobFieldState();
}

class _DobFieldState extends ConsumerState<DobField> {
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

    return TextFormField(
      controller: widget.textEditingController,
      cursorColor: ColorName.primary,
      autocorrect: false,
      keyboardType: TextInputType.datetime,
      style: textStyle,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter date of birth';
        }

        final regExp = RegExp(r'^\d{2}-\d{2}-\d{4}$');
        if (!regExp.hasMatch(value)) {
          return 'Enter date in DD-MM-YYYY format';
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
        labelText: 'Date Of Birth',
        labelStyle: labelStyle,
      ),
    );
  }
}
