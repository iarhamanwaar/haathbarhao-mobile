import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/providers/token_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/widgets/custom_text_field.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class OtpView extends ConsumerStatefulWidget {
  const OtpView({super.key});

  @override
  ConsumerState<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends ConsumerState<OtpView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  bool isLoading = false;

  Future<void> _verifyOtp(String verificationId, String name, String role,
      String phone, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: _otpController.text,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        String? idToken = await userCredential.user?.getIdToken();

        if (idToken != null) {
          ref.invalidate(tokenProvider);

          final userRepository = ref.read(userRepositoryProvider);

          await userRepository.signupWithEmail(
            name: name.trim(),
            role: role.trim(),
            phone: phone,
            password: password,
          );

          setState(() {
            isLoading = false;
          });

          if (mounted) {
            context.goNamed(
              AppRoute.main.name,
            );
          }
        } else {
          throw 'Invalid OTP code entered.';
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e is FirebaseAuthException) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: ColorName.primary,
        );
      }

      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = GoRouter.of(context).routerDelegate.currentConfiguration;
    final verificationId = state.uri.queryParameters['verificationId']!;
    final name = state.uri.queryParameters['name']!;
    final role = state.uri.queryParameters['role']!;
    final phone = state.uri.queryParameters['phone']!;
    final password = state.uri.queryParameters['password']!;

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
                    'Enter OTP',
                    style: TextStyle(
                      fontFamily: FontFamily.clashDisplay,
                      fontSize: 36,
                      color: ColorName.primaryBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    type: 'OTP',
                    textEditingController: _otpController,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    onPressed: () => _verifyOtp(
                      verificationId,
                      name,
                      role,
                      phone,
                      password,
                    ),
                    invertColors: true,
                    text: 'Verify',
                    isLoading: isLoading,
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
