import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../gen/colors.gen.dart';

class CustomTextField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  final String type;
  final Widget? suffixIcon;
  final Function()? onPressed;

  const CustomTextField({
    required this.textEditingController,
    this.type = 'Email',
    this.suffixIcon,
    this.onPressed,
    super.key,
  });

  @override
  ConsumerState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    String? Function(String?) validator = (value) {
      return null;
    };

    if (widget.type == 'Name' || widget.type == 'Title') {
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }

        return null;
      };
    } else if (widget.type == 'Email') {
      validator = (value) {
        // Check if this field is empty
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);
        // using regular expression
        if (!emailValid) {
          return "Please enter a valid email address";
        }
        // the email is valid
        return null;
      };
    } else if (widget.type == 'Password') {
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }

        return null;
      };
    } else if (widget.type == 'Role') {
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a role';
        }

        return null;
      };
    }

    return GestureDetector(
      onTap: widget.onPressed,
      child: TextFormField(
        enabled: widget.onPressed != null ? false : true,
        controller: widget.textEditingController,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorName.primaryBlack,
        ),
        validator: validator,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType:
            widget.type == 'Email' ? TextInputType.emailAddress : null,
        maxLines: widget.type == 'Description' ? 5 : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF929292).withOpacity(0.2),
          hintText: widget.type,
          hintStyle: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorName.lightGrey,
          ),
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: widget.type == 'Description'
                ? BorderRadius.circular(25)
                : BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: ColorName.white,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.type == 'Description'
                ? BorderRadius.circular(25)
                : BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: ColorName.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.type == 'Description'
                ? BorderRadius.circular(25)
                : BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: ColorName.white,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
