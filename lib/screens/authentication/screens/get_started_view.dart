import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../widgets/primary_button.dart';
import 'widgets/custom_text_field.dart';

class GetStartedView extends ConsumerStatefulWidget {
  const GetStartedView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<GetStartedView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  onPressed() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final userRepository = ref.read(userRepositoryProvider);

        await userRepository.signupWithEmail(
          name: _nameController.text.trim(),
          role: _roleController.text.trim(),
          email: _emailController.text.trim(),
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

    _nameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
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
                  const Text(
                    'Get started',
                    style: TextStyle(
                      fontFamily: FontFamily.clashDisplay,
                      fontSize: 36,
                      color: ColorName.primaryBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    type: 'Name',
                    textEditingController: _nameController,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    type: 'Role',
                    textEditingController: _roleController,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    type: 'Email',
                    textEditingController: _emailController,
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
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: ColorName.lightGrey,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => context.goNamed(AppRoute.login.name),
                          text: 'Log in',
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
