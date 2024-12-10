import 'package:ar_interior_visualizer/src/common_widgets/form/form_footer_widget.dart';
import 'package:ar_interior_visualizer/src/common_widgets/form/form_header_widget.dart';
import 'package:ar_interior_visualizer/src/common_widgets/styles/spacing_styles.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:ar_interior_visualizer/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_divider.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/login/login_controller.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: MyAppSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image, Title & Sub-Title
                const FormHeaderWidget(
                    image: MyAppImages.welcomeScreenImage,
                    title: MyAppTexts.loginTitle,
                    subTitle: MyAppTexts.loginSubTitle),
                /// Login Form
                const LoginForm(),
                /// Divider
                const FormDivider(dividerText: MyAppTexts.orSignInWith),
                /// Footer
                FormFooterWidget(
                    heightBetween: MyAppSizes.defaultSpace,
                    image: MyAppImages.googleLogoImage,
                    buttonText: MyAppTexts.signInWithGoogle,
                    onPressed: ()=> controller.googleSignIn(),
                    firstText: MyAppTexts.dontHaveAnAccount,
                    secondText: MyAppTexts.signup,
                    onTap: ()=>Get.offAll(() =>  const SignUpScreen()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
