import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';

class NameField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  final String text;

  const NameField({
    required this.textEditingController,
    required this.text,
    super.key,
  });

  @override
  ConsumerState createState() => _NameFieldState();
}

class _NameFieldState extends ConsumerState<NameField> {
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
        keyboardType: TextInputType.name,
        style: textStyle,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value == null || value == '') {
            return 'Enter a valid name';
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
          labelText: 'Name',
          labelStyle: labelStyle,
        ),
      ),
    );
  }
}
