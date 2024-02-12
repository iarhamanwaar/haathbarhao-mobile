import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  onPressed() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final auth = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        setState(() {
          isLoading = false;
        });

        if (auth.user != null) {
          await auth.user!.updateDisplayName(_nameController.text.trim());
          if (context.mounted) context.goNamed(AppRoute.main.name);
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(
        msg: e.message.toString(),
        backgroundColor: Colors.red,
      );

      log(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Container(
                  decoration: const BoxDecoration(
                    color: ColorName.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(25),
                  child: SvgPicture.asset(
                    Assets.icons.verifiedFilled,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Name',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: ColorName.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.inter(
                    color: ColorName.white,
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    isCollapsed: true,
                    isDense: true,
                    filled: true,
                    fillColor: ColorName.primary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Email',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: ColorName.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  style: GoogleFonts.inter(
                    color: ColorName.white,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  validator: (value) {
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
                  },
                  decoration: InputDecoration(
                    isCollapsed: true,
                    isDense: true,
                    filled: true,
                    fillColor: ColorName.primary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Password',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: ColorName.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  style: GoogleFonts.inter(
                    color: ColorName.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    isDense: true,
                    filled: true,
                    fillColor: ColorName.primary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      color: ColorName.primary,
                      fontSize: 15,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Do you already have ',
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.goNamed(AppRoute.login.name),
                        text: 'HaathBarhao',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: ' account?',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 235,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: onPressed,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorName.primary,
                      padding: EdgeInsets.zero,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'Register',
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              color: ColorName.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
