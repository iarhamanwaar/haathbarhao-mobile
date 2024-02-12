import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/core/app_export.dart';

// ignore: must_be_immutable
class JobcardlistItemWidget extends StatelessWidget {
  JobcardlistItemWidget({
    super.key,
    this.onTapJobCard,
  });

  VoidCallback? onTapJobCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapJobCard!.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 18.v,
        ),
        decoration: AppDecoration.white.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage3,
                      height: 40.adaptSize,
                      width: 40.adaptSize,
                      radius: BorderRadius.circular(
                        4.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        bottom: 4.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mid-level UX Designer ",
                            style: TextStyle(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontSize: 16.fSize,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Opacity(
                            opacity: 0.8,
                            child: Text(
                              "Total",
                              style: TextStyle(
                                color: theme.colorScheme.onPrimaryContainer
                                    .withOpacity(0.64),
                                fontSize: 12.fSize,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.v),
                Container(
                  width: 89.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 1.v,
                  ),
                  decoration: AppDecoration.bg.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                  ),
                  child: Text(
                    "Contractual",
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer
                          .withOpacity(0.64),
                      fontSize: 12.fSize,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Opacity(
              opacity: 0.8,
              child: Padding(
                padding: EdgeInsets.only(top: 56.v),
                child: Text(
                  "View Job",
                  style: TextStyle(
                    color:
                        theme.colorScheme.onPrimaryContainer.withOpacity(0.64),
                    fontSize: 12.fSize,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
