import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String? categoryId;
  String categoryName;
  String thumbnail;
  String title;
  String? description;
  String image;
  DateTime? date;

  ProductModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.image,
    required this.categoryName,
    this.description,
    this.categoryId,
    this.date,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', title: '', thumbnail: '', image: '', categoryName: '');

  /// Json Format
  Map<String, dynamic>toJson() {
    return {
      'Title': title,
      'Thumbnail': thumbnail,
      'Image': image,
      'CategoryId': categoryId,
      'CategoryName': categoryName,
      'Description': description,
    };
  }

  /// Factory constructor to create a ProductModel from a Firestore DocumentSnapshot. (Map Json to Model)
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      thumbnail: data['Thumbnail'] ?? '',
      image: data['Image'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      categoryName: data['CategoryName'] ??'',
      description: data['Description'] ??'',
    );
  }

  /// Factory constructor to create a ProductModel from a Firestore DocumentSnapshot by using Query. (Map Json to Model)
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      image: data['Image'] ?? '',
      categoryId: data['CategoryId'] ?? '' ,
      categoryName: data['CategoryName'] ??'',
      description: data['Description'] ??'',
    );
  }

}
