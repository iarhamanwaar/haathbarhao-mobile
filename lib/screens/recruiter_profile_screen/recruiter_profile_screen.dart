import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';
import 'package:haathbarhao_mobile/routes/app_routes.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:haathbarhao_mobile/widgets/custom_elevated_button.dart';
import 'package:haathbarhao_mobile/widgets/custom_switch.dart';

// ignore_for_file: must_be_immutable
class RecruiterProfileScreen extends StatelessWidget {
  RecruiterProfileScreen({super.key});

  bool isSelectedSwitch = false;

  bool isSelectedSwitch1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black900,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 2.v),
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgEllipse3192x192,
                      height: 192.adaptSize,
                      width: 192.adaptSize,
                      radius: BorderRadius.circular(96.h),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 33.h)),
                  SizedBox(height: 17.v),
                  Text("Toptal",
                      style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 32.fSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 9.v),
                  Text("Hiring Recruiter",
                      style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 32.fSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 21.v),
                  CustomElevatedButton(
                      width: 235.h,
                      text: "Post a Job",
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      onPressed: () {
                        onTapPostAJob(context);
                      }),
                  SizedBox(height: 24.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Posted",
                        style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 24.fSize,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700)),
                    Padding(
                        padding: EdgeInsets.only(left: 66.h),
                        child: Text("Hired",
                            style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 24.fSize,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700)))
                  ]),
                  SizedBox(height: 14.v),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 22.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.h, vertical: 17.v),
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
                                        horizontal: 19.h, vertical: 17.v),
                                    decoration: AppDecoration.fillPrimary
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder33),
                                    child: Text("01",
                                        style: TextStyle(
                                            color: theme.colorScheme.onPrimary,
                                            fontSize: 24.fSize,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700)))
                              ]))),
                  SizedBox(height: 33.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgFavoriteOnprimary,
                        height: 49.adaptSize,
                        width: 49.adaptSize),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 19.h, top: 8.v, bottom: 10.v),
                        child: Text("Favorite",
                            style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 24.fSize,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700))),
                    CustomSwitch(
                        margin: EdgeInsets.only(
                            left: 37.h, top: 10.v, bottom: 10.v),
                        value: isSelectedSwitch,
                        onChange: (value) {
                          isSelectedSwitch = value;
                        })
                  ]),
                  SizedBox(height: 34.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgSettingsPower,
                        height: 48.adaptSize,
                        width: 48.adaptSize,
                        margin: EdgeInsets.only(top: 8.v, bottom: 3.v),
                        onTap: () {
                          onTapImgSettingsPower(context);
                        }),
                    GestureDetector(
                        onTap: () {
                          onTapTxtSwitchSeeker(context);
                        },
                        child: Container(
                            width: 83.h,
                            margin: EdgeInsets.only(left: 24.h),
                            child: Text("Switch\nSeeker",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontSize: 24.fSize,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700)))),
                    CustomSwitch(
                        margin: EdgeInsets.only(
                            left: 44.h, top: 15.v, bottom: 15.v),
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
        height: 56.v,
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            margin: EdgeInsets.fromLTRB(31.h, 16.v, 375.h, 16.v),
            onTap: () {
              onTapIconNavigation(context);
            }));
  }

  /// Section Widget
  Widget _buildSignOut(BuildContext context) {
    return CustomElevatedButton(
        height: 76.v,
        width: 260.h,
        text: "Sign Out",
        margin: EdgeInsets.only(left: 89.h, right: 81.h, bottom: 39.v),
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
  onTapIconNavigation(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the jobPostScreen when the action is triggered.
  onTapPostAJob(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.jobPostScreen);
  }

  /// Navigates to the seekerProfileScreen when the action is triggered.
  onTapImgSettingsPower(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.seekerProfileScreen);
  }

  /// Navigates to the seekerProfileScreen when the action is triggered.
  onTapTxtSwitchSeeker(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.seekerProfileScreen);
  }

  onTapSignOut(BuildContext context) {
    // TODO: implement Actions
  }
}
