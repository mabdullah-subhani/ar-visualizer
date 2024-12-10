
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatters.dart';

class   UserModel {
  final String id;
   String firstName;
   String lastName;
   String userName;
   String email;
   String phoneNo;
   String profilePicture;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNo,
    required this.profilePicture,
  });

  // Helper function to get the full name.
  String get fullName => '$firstName $lastName';

// Helper function to format phone number.
  String get formattedPhoneNo => MyAppFormatter.formatPhoneNumber(phoneNo);

// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(' ');


/// Static function to generate a username from the full name.
  static String generateUsername(fullName,email) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';
    // Extract the email number
    String emailNo = RegExp(r'\d+').firstMatch(email)?.group(0) ?? '';

    String camelCaseUsername = '$firstName$lastName'; // Combine first and last name
    String usernameWithPrefix = '$camelCaseUsername$emailNo'; // Add "ar_" prefix

    return usernameWithPrefix;
  }

  /// Static Function to create an Empty User Model
  static UserModel empty()=> UserModel(id: '', firstName: '', lastName: '', userName: '', email: '', phoneNo: '', profilePicture: '');

  /// Convert UserModel to a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNo': phoneNo,
      'profilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        userName: data['userName'] ?? '',
        email: data['email'] ?? '',
        phoneNo: data['phoneNo'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    }else {
      return UserModel.empty();
    }
  }
}
