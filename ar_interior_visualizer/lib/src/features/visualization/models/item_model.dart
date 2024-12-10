
import 'package:cloud_firestore/cloud_firestore.dart';

class   ItemModel {
  final String? docId; // Firestore document ID (for edit/delete operations)
  final String id;    // User ID (current user)
  String image;
  String title;
  String category;
  String description;


  /// Constructor for ItemModel
  ItemModel(
 {  this.docId,
    required this.id,
    required this.image,
    required this.title,
    required this.category,
    required this.description,
  });


  /// Static Function to create an Empty ItemModel
  static ItemModel empty()=> ItemModel(docId: '', id: '', image: '', title: '', category: '', description: '', );

  /// Convert ItemModel to a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Image': image,
      'Title': title,
      'Category': category,
      'Description': description,
    };
  }

  /// Factory method to create a ItemModel from a Firebase document snapshot.
  factory ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ItemModel(
        docId: document.id,
          id: data['id'] ?? '',
        image: data['Image'] ?? '',
        title: data['Title'] ?? '',
        category: data['Category'] ?? '',
        description: data['Description'] ?? '',

      );
    }else {
      return ItemModel.empty();
    }
  }
}
