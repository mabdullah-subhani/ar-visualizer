import 'package:ar_interior_visualizer/src/utils/constants/sizes.dart';
import 'package:ar_interior_visualizer/src/utils/constants/text_strings.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/images_strings.dart';
import '../login/login_screen.dart';
import '../signup/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MyAppHelperFunctions.screenSize(); // Get screen size
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: screenWidth, // Full screen width
            height: screenHeight, // Full screen height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: dark? AssetImage(MyAppImages.welcomeScreenDarkBackImage) :AssetImage(MyAppImages.welcomeScreenLightBackImage) ,
                fit: BoxFit.cover, // Adjust the image to cover the entire screen
              ),
            ),
          ),

          // Content (Buttons)
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Signup Button (Outlined)
                  OutlinedButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    child: Text(
                      MyAppTexts.signup.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: MyAppSizes.spaceBtwItems),

                  // Login Button (Elevated)
                  ElevatedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: Text(
                      MyAppTexts.login.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Add spacing at the bottom
                  SizedBox(height: dark ? MyAppSizes.spaceBtwSections * 0.8 : MyAppSizes.spaceBtwSections * 1.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
