import 'package:ar_interior_visualizer/src/routing/routes.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/signup/signup_screen.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/personalization/screens/settings/settings.dart';
import '../features/visualization/screens/favourite/favourite.dart';
import '../features/visualization/screens/home/home.dart';

class MyAppPageRoutes {
  static final pages = [
    GetPage(name: MyAppRoutes.home, page: () => const HomeScreen()),
    // GetPage(name: MyAppRoutes.store, page: () => const StoreScreen()),
    GetPage(name: MyAppRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: MyAppRoutes.settings, page: () => const SettingsScreen()),
    // GetPage(name: MyAppRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: MyAppRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: MyAppRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: MyAppRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: MyAppRoutes.signIn, page: () => const LoginScreen()),
    // GetPage(name: MyAppRoutes.forgetPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: MyAppRoutes.onBoarding, page: () => const OnBoardingScreen()),
    // Add more GetPage entries as needed
  ];
}