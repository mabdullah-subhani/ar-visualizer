
import 'package:ar_interior_visualizer/src/features/visualization/models/item_model.dart';
import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/appbar/appbar.dart';




class VirtualARViewScreen extends StatefulWidget {
  const VirtualARViewScreen({super.key, required this.item, });

  final ItemModel item;

  @override
  State<VirtualARViewScreen> createState() => _VirtualARViewScreenState();
}

class _VirtualARViewScreenState extends State<VirtualARViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('AR View', style: Theme
            .of(context)
            .textTheme
            .headlineSmall),
        showBackArrow: true,
      ),
      body: AugmentedRealityPlugin(widget.item.image),

    );
  }
}




//
// class VirtualARViewScreen extends StatefulWidget {
//    VirtualARViewScreen({super.key,  required this.filteredImage,
//
//
//     // required this.item,
//
//   });
//
//   // final ItemModel item;
//    final Image filteredImage; // The newly generated image URL with the applied color
//
//
//   @override
//   State<VirtualARViewScreen> createState() => _VirtualARViewScreenState();
// }
//
// class _VirtualARViewScreenState extends State<VirtualARViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         title: Text('AR View', style: Theme
//             .of(context)
//             .textTheme
//             .headlineSmall),
//         showBackArrow: true,
//       ),
//       body: AugmentedRealityPlugin(widget.filteredImage.toString()),
//
//     );
//   }
// }






