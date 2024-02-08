import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/objects/service_call.dart';

class Review {
  String? reviewId;
  AppUser? customerID;
  AppUser? providerID;
  ServiceCall? serviceCallID;
  int? rating;
  String? reviewDesc;

  Review({
    required this.reviewId,
    required this.customerID,
    required this.providerID,
    required this.serviceCallID,
    required this.rating,
    required this.reviewDesc,
  });
  // Function to add user data to Firestore
  static Future<void> addReviewDataToFirestore(Review review) async {
    CollectionReference reviews =
        FirebaseFirestore.instance.collection('reviews');

    await reviews.add({
      'customerID': review.customerID?.userId,
      'providerID': review.providerID?.userId,
      'serviceCall': review.serviceCallID?.serviceCallId,
      'rating': review.rating,
      'reviewDesc': review.reviewDesc,
    }).then((value) {
      // Document added successfully
      print('Data stored in Firestore!');
    }).catchError((error) {
      // Handle errors
      print('Error storing data in Firestore: $error');
    });
  }
}
