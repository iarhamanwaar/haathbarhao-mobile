import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';
import 'package:haathbarhao_mobile/routes/app_routes.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:haathbarhao_mobile/widgets/custom_elevated_button.dart';
import 'package:haathbarhao_mobile/widgets/custom_switch.dart';

// ignore_for_file: must_be_immutable
class SeekerProfileScreen extends StatelessWidget {
  SeekerProfileScreen({super.key});

  bool isSelectedSwitch = false;

  bool isSelectedSwitch1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black900,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgEllipse3,
                      height: 192.adaptSize,
                      width: 192.adaptSize,
                      radius: BorderRadius.circular(96.h),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 36.h)),
                  SizedBox(height: 13.v),
                  Text("Ossama M.",
                      style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 32.fSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 11.v),
                  Text("UI/UX",
                      style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 32.fSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 38.v),
                  CustomElevatedButton(
                      width: 235.h,
                      text: "STATISTICS",
                      buttonStyle: CustomButtonStyles.fillPrimary),
                  SizedBox(height: 22.v),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 9.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 1.v),
                                    child: Text("Applied",
                                        style: TextStyle(
                                            color: theme.colorScheme.onPrimary,
                                            fontSize: 24.fSize,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700))),
                                Padding(
                                    padding: EdgeInsets.only(left: 46.h),
                                    child: Text("Process",
                                        style: TextStyle(
                                            color: theme.colorScheme.onPrimary,
                                            fontSize: 24.fSize,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700)))
                              ]))),
                  SizedBox(height: 12.v),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 25.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.h, vertical: 18.v),
                                    decoration: AppDecoration.fillPrimary
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder33),
                                    child: Text("05",
                                        style: TextStyle(
                                            color: theme.colorScheme.onPrimary,
                                            fontSize: 24.fSize,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700))),
                                Container(
                                    margin: EdgeInsets.only(left: 71.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.h, vertical: 18.v),
                                    decoration: AppDecoration.fillPrimary
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder33),
                                    child: Text("00",
                                        style: TextStyle(
                                            color: theme.colorScheme.onPrimary,
                                            fontSize: 24.fSize,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700)))
                              ]))),
                  SizedBox(height: 41.v),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgClock,
                                height: 43.adaptSize,
                                width: 43.adaptSize),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 22.h, bottom: 12.v),
                                child: Text("Reminder",
                                    style: TextStyle(
                                        color: theme.colorScheme.onPrimary,
                                        fontSize: 24.fSize,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700))),
                            CustomSwitch(
                                margin: EdgeInsets.only(
                                    left: 23.h, top: 7.v, bottom: 8.v),
                                value: isSelectedSwitch,
                                onChange: (value) {
                                  isSelectedSwitch = value;
                                })
                          ])),
                  SizedBox(height: 34.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgFavoriteOnprimary,
                        height: 49.adaptSize,
                        width: 49.adaptSize),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 18.h, top: 11.v, bottom: 7.v),
                        child: Text("Priority",
                            style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 24.fSize,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700))),
                    CustomSwitch(
                        margin: EdgeInsets.only(
                            left: 49.h, top: 10.v, bottom: 10.v),
                        value: isSelectedSwitch1,
                        onChange: (value) {
                          isSelectedSwitch1 = value;
                        })
                  ]),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildSignOut(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 53.v,
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            margin: EdgeInsets.only(left: 25.h, bottom: 12.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSettingsPower,
              margin: EdgeInsets.symmetric(horizontal: 18.h),
              onTap: () {
                onTapSettingsPower(context);
              })
        ]);
  }

  /// Section Widget
  Widget _buildSignOut(BuildContext context) {
    return CustomElevatedButton(
        height: 76.v,
        width: 260.h,
        text: "Sign Out",
        margin: EdgeInsets.only(left: 89.h, right: 81.h, bottom: 33.v),
        rightIcon: Container(
            margin: EdgeInsets.only(left: 15.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgArrowleft,
                height: 38.v,
                width: 42.h)),
        buttonStyle: CustomButtonStyles.fillPrimaryTL38,
        onPressed: () {
          onTapSignOut(context);
        });
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the recruiterProfileScreen when the action is triggered.
  onTapSettingsPower(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recruiterProfileScreen);
  }

  onTapSignOut(BuildContext context) {
    // TODO: implement Actions
  }
}
