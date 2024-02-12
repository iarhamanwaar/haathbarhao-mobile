import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';
import 'package:haathbarhao_mobile/routes/app_routes.dart';
import 'package:haathbarhao_mobile/widgets/custom_drop_down.dart';
import 'package:haathbarhao_mobile/widgets/custom_elevated_button.dart';
import 'package:haathbarhao_mobile/widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class JobPostScreen extends StatelessWidget {
  JobPostScreen({super.key});

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray50,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 9.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35.v),
                      _buildSettingsPowerRow(context),
                      SizedBox(height: 66.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 64.adaptSize,
                          width: 64.adaptSize,
                          radius: BorderRadius.circular(4.h),
                          margin: EdgeInsets.only(left: 28.h)),
                      SizedBox(height: 18.v),
                      Padding(
                          padding: EdgeInsets.only(left: 28.h),
                          child: Text("Mid-level UX Designer ",
                              style: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontSize: 26.fSize,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500))),
                      Opacity(
                          opacity: 0.8,
                          child: Padding(
                              padding: EdgeInsets.only(left: 28.h),
                              child: Text("Toptal",
                                  style: TextStyle(
                                      color: theme
                                          .colorScheme.onPrimaryContainer
                                          .withOpacity(0.64),
                                      fontSize: 14.fSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500)))),
                      Opacity(
                          opacity: 0.6,
                          child: Padding(
                              padding: EdgeInsets.only(left: 28.h),
                              child: Text("Posted on 20 July",
                                  style: TextStyle(
                                      color: theme
                                          .colorScheme.onPrimaryContainer
                                          .withOpacity(0.56),
                                      fontSize: 12.fSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400)))),
                      SizedBox(height: 48.v),
                      Padding(
                          padding: EdgeInsets.only(left: 28.h, right: 81.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Opacity(
                                          opacity: 0.75,
                                          child: Text(
                                              "Apply Before".toUpperCase(),
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer
                                                      .withOpacity(0.62),
                                                  fontSize: 11.5.fSize,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w700))),
                                      SizedBox(height: 5.v),
                                      Text("30 July, 2021",
                                          style: TextStyle(
                                              color: theme.colorScheme
                                                  .onPrimaryContainer,
                                              fontSize: 14.fSize,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400))
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Opacity(
                                          opacity: 0.75,
                                          child: Text(
                                              "Job Nature".toUpperCase(),
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer
                                                      .withOpacity(0.62),
                                                  fontSize: 11.5.fSize,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w700))),
                                      SizedBox(height: 5.v),
                                      Container(
                                          width: 89.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.h, vertical: 1.v),
                                          decoration: AppDecoration.bg.copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder12),
                                          child: Text("Contractual",
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer
                                                      .withOpacity(0.64),
                                                  fontSize: 12.fSize,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500)))
                                    ])
                              ])),
                      SizedBox(height: 16.v),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: EdgeInsets.only(left: 28.h, right: 24.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 1.v),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Opacity(
                                                  opacity: 0.75,
                                                  child: Text(
                                                      "Salary Range"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimaryContainer
                                                              .withOpacity(
                                                                  0.62),
                                                          fontSize: 11.5.fSize,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight
                                                              .w700))),
                                              SizedBox(height: 3.v),
                                              Text("100k - 120k/yearly",
                                                  style: TextStyle(
                                                      color: theme.colorScheme
                                                          .onPrimaryContainer,
                                                      fontSize: 14.fSize,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ])),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Opacity(
                                              opacity: 0.75,
                                              child: Text(
                                                  "Job Location".toUpperCase(),
                                                  style: TextStyle(
                                                      color: theme.colorScheme
                                                          .onPrimaryContainer
                                                          .withOpacity(0.62),
                                                      fontSize: 11.5.fSize,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          SizedBox(height: 5.v),
                                          Text("Work from anywhere",
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer,
                                                  fontSize: 14.fSize,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400))
                                        ])
                                  ]))),
                      SizedBox(height: 47.v),
                      Opacity(
                          opacity: 0.75,
                          child: Padding(
                              padding: EdgeInsets.only(left: 28.h),
                              child: Text("Job Description".toUpperCase(),
                                  style: TextStyle(
                                      color: theme
                                          .colorScheme.onPrimaryContainer
                                          .withOpacity(0.62),
                                      fontSize: 11.5.fSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700)))),
                      SizedBox(height: 8.v),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 343.h,
                              margin: EdgeInsets.only(left: 28.h, right: 14.h),
                              child: Text(
                                  "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye?\nWe believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 14.fSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400)))),
                      SizedBox(height: 13.v),
                      Padding(
                          padding: EdgeInsets.only(left: 28.h),
                          child: CustomDropDown(
                              width: 85.h,
                              icon: Container(
                                  margin: EdgeInsets.only(left: 4.h),
                                  child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgArrowdropdown24px,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize)),
                              hintText: "See more",
                              items: dropdownItemList,
                              onChanged: (value) {})),
                      SizedBox(height: 13.v),
                      Opacity(
                          opacity: 0.75,
                          child: Padding(
                              padding: EdgeInsets.only(left: 28.h),
                              child: Text("Benefits".toUpperCase(),
                                  style: TextStyle(
                                      color: theme
                                          .colorScheme.onPrimaryContainer
                                          .withOpacity(0.62),
                                      fontSize: 11.5.fSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700)))),
                      SizedBox(height: 9.v),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 179.v,
                              width: 342.h,
                              child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                            width: 342.h,
                                            child: Text(
                                                "• Market competitive salaries \n• Medical Insurance \n• EOBI \n• Provident Fund \n• Leaves Encasement \n• Yearly Bonuses \n• Monthly Rewarding Schemes \n• Good work-life balance & healthy and fun-filled office.",
                                                maxLines: 9,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: appTheme.black900,
                                                    fontSize: 14.fSize,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w400)))),
                                    CustomElevatedButton(
                                        height: 52.v,
                                        width: 174.h,
                                        text: "POST JOB",
                                        margin: EdgeInsets.only(
                                            left: 74.h, top: 14.v),
                                        buttonStyle: CustomButtonStyles
                                            .outlineErrorContainerTL121,
                                        onPressed: () {
                                          onTapPOSTJOB(context);
                                        },
                                        alignment: Alignment.topLeft)
                                  ])))
                    ]))));
  }

  /// Section Widget
  Widget _buildSettingsPowerRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(bottom: 4.v),
              child: CustomIconButton(
                  height: 44.adaptSize,
                  width: 44.adaptSize,
                  onTap: () {
                    onTapBtnIconButton(context);
                  },
                  child: CustomImageView(
                      imagePath: ImageConstant.imgEllipse244x44))),
          CustomImageView(
              imagePath: ImageConstant.imgSettingsPowerPrimary,
              height: 48.adaptSize,
              width: 48.adaptSize,
              onTap: () {
                onTapImgSettingsPower(context);
              })
        ]));
  }

  /// Navigates to the recruiterProfileScreen when the action is triggered.
  onTapBtnIconButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recruiterProfileScreen);
  }

  /// Navigates to the seekerProfileScreen when the action is triggered.
  onTapImgSettingsPower(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.seekerProfileScreen);
  }

  /// Navigates to the recruiterProfileScreen when the action is triggered.
  onTapPOSTJOB(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recruiterProfileScreen);
  }
}
