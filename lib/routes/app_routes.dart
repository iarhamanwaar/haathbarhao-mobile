import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/screens/notification_screen/notification_screen.dart';
import 'package:haathbarhao_mobile/screens/seeker_profile_screen/seeker_profile_screen.dart';
import 'package:haathbarhao_mobile/screens/become_recruitee_screen/become_recruitee_screen.dart';
import 'package:haathbarhao_mobile/screens/job_post_screen/job_post_screen.dart';
import 'package:haathbarhao_mobile/screens/recruiter_profile_screen/recruiter_profile_screen.dart';
import 'package:haathbarhao_mobile/screens/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String notificationScreen = '/notification_screen';

  static const String seekerProfileScreen = '/seeker_profile_screen';

  static const String becomeRecruiteeScreen = '/become_recruitee_screen';

  static const String jobPostScreen = '/job_post_screen';

  static const String recruiterProfileScreen = '/recruiter_profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    notificationScreen: (context) => const NotificationScreen(),
    seekerProfileScreen: (context) => SeekerProfileScreen(),
    becomeRecruiteeScreen: (context) => const BecomeRecruiteeScreen(),
    jobPostScreen: (context) => JobPostScreen(),
    recruiterProfileScreen: (context) => RecruiterProfileScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen()
  };
}
