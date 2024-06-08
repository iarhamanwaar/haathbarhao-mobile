import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/providers/token_provider.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../providers/user_repo_provider.dart';
import '../../../../widgets/primary_button.dart';
import 'widgets/custom_text_field.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  onPressed() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        ref.invalidate(tokenProvider);

        String phoneNumber = _phoneController.text.trim();
        if (phoneNumber.startsWith('0')) {
          phoneNumber = '+92${phoneNumber.substring(1)}';
        }

        final userRepository = ref.read(userRepositoryProvider);

        await userRepository.loginWithEmail(
          phone: phoneNumber,
          password: _passwordController.text,
        );

        setState(() {
          isLoading = false;
        });

        if (mounted) context.goNamed(AppRoute.main.name);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: ColorName.primary,
      );

      log(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();

    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: ColorName.white,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome ',
                        style: TextStyle(
                          fontFamily: FontFamily.clashDisplay,
                          fontSize: 36,
                          color: ColorName.primaryBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'back',
                        style: TextStyle(
                          fontFamily: FontFamily.clashDisplay,
                          fontSize: 36,
                          color: ColorName.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    type: 'Phone',
                    textEditingController: _phoneController,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    type: 'Password',
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    onPressed: onPressed,
                    invertColors: true,
                    text: 'Continue',
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 25),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: ColorName.lightGrey,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => context.goNamed(AppRoute.register.name),
                          text: 'Sign up',
                          style: const TextStyle(
                            color: ColorName.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
