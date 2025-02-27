import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  });

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment  ;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        /// Image
        Center(
          child: Image(
            image: AssetImage(image),
            color: imageColor,
            height: size.height * imageHeight,
          ),
        ),
        SizedBox(height: heightBetween),
        /// Title
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 10.0),
        /// Sub-Title
        Text(subTitle, textAlign: textAlign, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
