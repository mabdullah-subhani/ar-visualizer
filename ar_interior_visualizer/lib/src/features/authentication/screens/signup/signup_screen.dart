import 'package:ar_interior_visualizer/src/common_widgets/form/form_divider.dart';
import 'package:ar_interior_visualizer/src/common_widgets/form/form_footer_widget.dart';
import 'package:ar_interior_visualizer/src/common_widgets/form/form_header_widget.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/login/login_screen.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:ar_interior_visualizer/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/login/login_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image, Title & Sub-Title
                 const FormHeaderWidget(
                    image: MyAppImages.signUpScreenImage,
                    title: MyAppTexts.signUpTitle,
                    subTitle: MyAppTexts.signUpSubTitle),
                 /// Sign-Up Form
                 const SignUpFormWidget(),
                /// Divider
                const FormDivider(dividerText: MyAppTexts.orSignUpWith),
                /// Footer
                FormFooterWidget(
                    heightBetween: MyAppSizes.buttonHeight,
                    image: MyAppImages.googleLogoImage,
                    buttonText: MyAppTexts.signUpWithGoogle,
                    onPressed: ()=> controller.googleSignIn(),
                    firstText: MyAppTexts.alreadyHaveAnAccount,
                    secondText: MyAppTexts.login,
                    onTap: ()=>Get.offAll(() =>  const LoginScreen())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
