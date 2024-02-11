import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/objects/provider_user.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/objects/service_call.dart';

class Review {
  AppUser? customerID;
  AppUser? providerID;
  ServiceCall? serviceCallID;
  int? rating;
  String? reviewDesc;

  Review({
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

  static Future<Review?> getReviewCallById(String serviceCallId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('reviews')
              .where('serviceCall', isEqualTo: serviceCallId)
              .get();

      // Check if there are any matching documents
      if (querySnapshot.docs.isNotEmpty) {
        // Access the first document in the snapshot
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;

        // Create a review instance from the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        return Review(
            customerID: await AppUser.getUserById(data['customerID']),
            providerID: await ProviderUser.getUserById(data['providerID']),
            serviceCallID:
                await ServiceCall.getServiceCallById(data['serviceCall']),
            rating: data['rating'],
            reviewDesc: data['reviewDesc']);
      } else {
        // No matching documents found
        return null;
      }
    } catch (error) {
      print('Error retrieving user data: $error');
      return null;
    }
  }
}
