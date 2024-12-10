import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:ar_interior_visualizer/src/utils/constants/images_strings.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(showBackArrow: true,),
      body:  ModelViewer(src: MyAppImages.sofa3DModel,
        ar: true,),
    );
  }
}
