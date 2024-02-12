// Extended class with additional property
import 'package:help_app/objects/review.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/objects/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderUser extends AppUser {
  late num rating;

  ProviderUser({
    required String userId,
    required String name,
    required String email,
    required int type,
    required this.rating,
  }) : super(
          userId: userId,
          name: name,
          email: email,
          type: type,
        );

  // Override the getUserById method to return additional information
  static Future<ProviderUser?> getUserById(String? userId) async {
    if (userId == null) return null;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: userId)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Create a ProviderUser instance

        ProviderUser user = ProviderUser(
          userId: data['userId'] ?? '',
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          rating: data['rating'] ?? '0',
          type: data['type'] ?? 0,
        );

        return user;
      } else {
        return null;
      }
    } catch (error) {
      print('Error retrieving user data: $error');
      return null;
    }
  }

  // send user data to firestore
  static Future<void> addUserDataToFirestore(
      String name, String email, String userId, int type, num rating) async {
    // set connection to users collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({
      'userId': userId,
      'name': name,
      'email': email,
      'type': type,
      'rating': rating,
    });
  }

  // get provider rating based on all his reviews
  Future<num> getRating() async {
    // get all provider calls
    List<ServiceCall?> calls = await ServiceCall.getAllProviderPosts(userId);

    // filter only reviewed calls
    List<ServiceCall?> reviewedCalls =
        calls.where((call) => call?.isReviewed == true).toList();
    Review? review;
    num total_rating = 0;
    num reviews_count = 0;
    // Iterate over all reviewedCalls
    for (var call in reviewedCalls) {
      review = await call?.getReview();
      if (review != null) {
        total_rating += review.rating ?? 0;
        reviews_count++;
      }
    }

    return (reviews_count != 0) ? total_rating / reviews_count : 0;
  }
}
