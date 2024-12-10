import 'package:ar_interior_visualizer/src/features/visualization/models/category_model.dart';
import 'package:ar_interior_visualizer/src/features/visualization/models/product_model.dart';
import 'package:ar_interior_visualizer/src/utils/constants/images_strings.dart';

class MyAppDummyData{

 static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: MyAppImages.sofaIcon, name: 'Sofa', isFeatured: true),
    CategoryModel(id: '2', image: MyAppImages.tableIcon, name: 'Table', isFeatured: true),
    CategoryModel(id: '3', image: MyAppImages.chairIcon, name: 'Chair', isFeatured: true),
    CategoryModel(id: '4', image: MyAppImages.bedIcon, name: 'Bed', isFeatured: true),
    CategoryModel(id: '5', image: MyAppImages.lampIcon, name: 'Lamp', isFeatured: true),
    CategoryModel(id: '6', image: MyAppImages.sideTableIcon, name: 'Side Table', isFeatured: true),

  ];


 /// List of all Products
 static final List<ProductModel> products = [
   ProductModel(
     id: '001',
     title: 'Modern Leather Sofa',
     categoryName: 'Sofa',
     thumbnail: MyAppImages.sofaThumbnail,
     image: MyAppImages.sofa3DModel,
     description: 'This sleek and stylish sofa is upholstered in rich leather, offering both comfort and durability. Its clean lines and minimalist design make it a versatile piece that complements various interior styles. Perfect for relaxing or entertaining guests.',
     categoryId: '1',

   ),
      ProductModel(
     id: '002',
     title: 'Upholstered Bed ',
     categoryName: 'Bed',
     thumbnail: MyAppImages.bedThumbnail,
     image: MyAppImages.bed3DModel,
     description: 'This elegant bed features a plush upholstered headboard with vertical channel quilting and integrated sconces for a touch of luxury. The solid wood base provides sturdy support and a clean, modern look. Perfect for creating a serene and stylish bedroom ambiance.',
     categoryId: '4',

   ),
      ProductModel(
     id: '003',
     title: 'Ergonomic Office-Chair',
     categoryName: 'Chair',
     thumbnail: MyAppImages.chairThumbnail,
     image: MyAppImages.chair3DModel,
     description: 'This sleek and functional office chair is designed to provide optimal comfort and support during long work hours. The adjustable height, swivel base, and ergonomic backrest promote good posture and reduce fatigue.',
        categoryId: '3',

   ),
      ProductModel(
     id: '004',
     title: 'Modern Table Lamp',
     categoryName: 'Lamp',
     thumbnail: MyAppImages.lampThumbnail,
     image: MyAppImages.lamp3DModel,
     description: 'This stylish table lamp features a warm wooden base with intricate carvings and a classic bell-shaped shade. Its timeless design complements a variety of interior styles, adding a touch of vintage charm to any room. Perfect for bedside tables, living rooms, or home offices.',
        categoryId: '5',

   ),

   ProductModel(
     id: '005',
     title: 'Elegant Wingback Chair',
     categoryName: 'Chair',
     thumbnail: MyAppImages.singleSofaThumbnail,
     image: MyAppImages.singleSofa3DModel,
     description: 'This luxurious wingback chair features a deep teal velvet upholstery with gold button accents. The high back and rolled arms provide exceptional comfort and support. The sleek wooden legs add a touch of modern elegance to this timeless design.',
     categoryId: '3',

   ),

 ];
}
