// import 'package:ar_interior_visualizer/src/features/visualization/screens/ar_view/virtual_ar_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../models/item_model.dart'; // For handling images and their data
//
// class ColorEditorScreen extends StatefulWidget {
//   final ItemModel item; // Original Image URL
//
//   const ColorEditorScreen({super.key, required this.item});
//
//   @override
//   _ColorEditorScreenState createState() => _ColorEditorScreenState();
// }
//
// class _ColorEditorScreenState extends State<ColorEditorScreen> {
//   Color selectedColor = Colors.white; // Default color
//   Image? filteredImage; // Store the Image widget (filtered)
//
//   // Function to apply color filter to image and store it
//   Future<void> applyColorFilterToImage(Color color) async {
//     // Load the image from the network
//     final Image networkImage = Image.network(widget.item.image);
//
//     // Simulate image processing: Apply color filter and store the result in filteredImage
//     setState(() {
//       filteredImage = networkImage; // Apply transformation here
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Image Color")),
//       body: Column(
//         children: [
//           // Image Display with the selected color applied
//           Expanded(
//             child: Stack(
//               children: [
//                 Image.network(widget.item.image), // Original Image
//                 ColorFiltered(
//                   colorFilter: ColorFilter.mode(
//                     selectedColor.withOpacity(1), // Adjust transparency
//                     BlendMode.modulate, // Blend the color with the image
//                   ),
//                   child: filteredImage ?? Image.network(widget.item.image), // Apply the selected color
//                 ),
//               ],
//             ),
//           ),
//           // Color Selection Sliders
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () => changeColor(Colors.red),
//                   child: Container(width: 40, height: 40, color: Colors.red),
//                 ),
//                 const SizedBox(width: 10),
//                 GestureDetector(
//                   onTap: () => changeColor(Colors.green),
//                   child: Container(width: 40, height: 40, color: Colors.green),
//                 ),
//                 const SizedBox(width: 10),
//                 GestureDetector(
//                   onTap: () => changeColor(Colors.blue),
//                   child: Container(width: 40, height: 40, color: Colors.blue),
//                 ),
//               ],
//             ),
//           ),
//           // Next Button to go to AR View with the new colored image
//           ElevatedButton(
//             onPressed: () {
//               if (filteredImage != null) {
//                 // Pass the filtered image to the next screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => VirtualARViewScreen(filteredImage: filteredImage!),
//                   ),
//                 );
//               }
//             },
//             child: const Text("Next"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Update selected color
//   void changeColor(Color color) {
//     setState(() {
//       selectedColor = color;
//       // Apply the color filter after the color is selected
//       applyColorFilterToImage(color);
//     });
//   }
// }
//
