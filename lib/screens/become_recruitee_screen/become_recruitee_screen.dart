import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';
import 'package:haathbarhao_mobile/routes/app_routes.dart';
import 'package:haathbarhao_mobile/widgets/custom_elevated_button.dart';

class BecomeRecruiteeScreen extends StatelessWidget {
  const BecomeRecruiteeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 1.v),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(left: 2.h),
                              padding: EdgeInsets.symmetric(vertical: 49.v),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 82.v),
                                    CustomImageView(
                                        imagePath:
                                            ImageConstant.imgEllipse2128x128,
                                        height: 128.adaptSize,
                                        width: 128.adaptSize,
                                        radius: BorderRadius.circular(64.h)),
                                    SizedBox(height: 36.v),
                                    SizedBox(
                                        width: 120.h,
                                        child: Text("Recruitee Username",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    theme.colorScheme.primary,
                                                fontSize: 24.fSize,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700))),
                                    SizedBox(height: 5.v),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            height: 51.v,
                                            width: 261.h,
                                            decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.primary,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(26.h),
                                                    topRight:
                                                        Radius.circular(25.h),
                                                    bottomLeft:
                                                        Radius.circular(26.h),
                                                    bottomRight:
                                                        Radius.circular(
                                                            25.h))))),
                                    SizedBox(height: 36.v),
                                    SizedBox(
                                        width: 107.h,
                                        child: Text("Business\nEmail",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    theme.colorScheme.primary,
                                                fontSize: 24.fSize,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700))),
                                    SizedBox(height: 5.v),
                                    Container(
                                        height: 51.v,
                                        width: 261.h,
                                        decoration: BoxDecoration(
                                            color: theme.colorScheme.primary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(26.h),
                                                topRight: Radius.circular(25.h),
                                                bottomLeft:
                                                    Radius.circular(26.h),
                                                bottomRight:
                                                    Radius.circular(25.h)))),
                                    SizedBox(height: 37.v),
                                    CustomImageView(
                                        imagePath: ImageConstant.imgFingerprint,
                                        height: 80.v,
                                        width: 71.h,
                                        onTap: () {
                                          onTapImgFingerprint(context);
                                        }),
                                    SizedBox(height: 27.v),
                                    SizedBox(
                                        width: 132.h,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "Already have account? ",
                                                  style: theme
                                                      .textTheme.titleLarge),
                                              TextSpan(
                                                  text: "Tap Fingerprint",
                                                  style: CustomTextStyles
                                                      .titleLargeExtraBold)
                                            ]),
                                            textAlign: TextAlign.center)),
                                    SizedBox(height: 27.v),
                                    CustomElevatedButton(
                                        width: 235.h,
                                        text: "Register",
                                        buttonStyle:
                                            CustomButtonStyles.fillPrimary,
                                        onPressed: () {
                                          onTapRegister(context);
                                        })
                                  ]))))
                ]))));
  }

  /// Navigates to the recruiterProfileScreen when the action is triggered.
  onTapImgFingerprint(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recruiterProfileScreen);
  }

  /// Navigates to the recruiterProfileScreen when the action is triggered.
  onTapRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recruiterProfileScreen);
  }
}
