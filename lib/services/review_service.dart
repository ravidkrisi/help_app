import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService {
  final CollectionReference<Map<String, dynamic>> _firestore =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> addReview({
    required String customerId,
    required String providerId,
    required String callId,
    required num rating,
    required String desc,
  }) async {
    Map<String, dynamic> data = {
      'customerId': customerId,
      'providerId': providerId,
      'callId': callId,
      'rating': rating,
      'desc': desc
    };

    try {
      // add serivce to db
      await _firestore.add(data);
      print('added review to db');
    } catch (e) {
      print('Error adding service call: $e');
    }
  }
}
