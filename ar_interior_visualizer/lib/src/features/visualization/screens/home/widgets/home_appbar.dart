import 'package:ar_interior_visualizer/src/common_widgets/loaders/shimmer/shimmer_effect.dart';
import 'package:ar_interior_visualizer/src/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/products_cart/cart_menu_icon.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(MyAppTexts.homeAppBarTitle, style: Theme.of(context).textTheme.labelMedium?.apply(color: Colors.white)),
          Obx((){
            if(controller.profileLoading.value){
              // Display shimmer loader effect while user name is being loaded
              return const MyAppShimmerEffect(width: 80, height: 15);
            }else{
              return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white));
            }
          }
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: MyAppSizes.defaultSpace/2),
          child: MyAppCartCounterIcon(onPressed: () { },iconColor: Colors.white),
        ),
      ],
    );
  }
}
