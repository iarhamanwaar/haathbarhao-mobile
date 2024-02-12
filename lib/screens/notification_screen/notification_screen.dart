import '../notification_screen/widgets/jobcardlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:haathbarhao_mobile/widgets/app_bar/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 33.h),
                child: Column(children: [
                  SizedBox(height: 10.v),
                  Container(
                      height: 122.adaptSize,
                      width: 122.adaptSize,
                      padding: EdgeInsets.symmetric(
                          horizontal: 34.h, vertical: 29.v),
                      decoration: AppDecoration.fillPrimary.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder61),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgIconSocialNot,
                          height: 62.v,
                          width: 51.h,
                          alignment: Alignment.center)),
                  SizedBox(height: 66.v),
                  _buildJobCardList(context)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgIconNavigation,
            margin: EdgeInsets.fromLTRB(31.h, 6.v, 375.h, 6.v),
            onTap: () {
              onTapIconNavigation(context);
            }));
  }

  /// Section Widget
  Widget _buildJobCardList(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(right: 1.h),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.v);
                },
                itemCount: 7,
                itemBuilder: (context, index) {
                  return JobcardlistItemWidget(onTapJobCard: () {
                    onTapJobCard(context);
                  });
                })));
  }

  onTapJobCard(BuildContext context) {}

  /// Navigates back to the previous screen.
  onTapIconNavigation(BuildContext context) {
    Navigator.pop(context);
  }
}
