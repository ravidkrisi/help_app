import 'package:flutter/material.dart';
import 'package:help_app/model/service_call.dart';
import 'package:help_app/services/review_service.dart';
import 'package:help_app/services/service_call_service.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/view/pages/history_page.dart';

class ReviewViewModel extends ChangeNotifier {
  final ReviewService _reviewService = ReviewService();
  final ServiceCallService _serviceCallService = ServiceCallService();
  final UserService _userService = UserService();
  ServiceCall? _call;

  List<int> ratings = [1, 2, 3, 4, 5];

  num _rating = 0;
  String _desc = '';

  // getters
  get rating => this._rating;
  get desc => this._desc;

  // setters
  set rating(value) => this._rating = value;
  set desc(value) => this._desc = value;
  set call(value) => this._call = value;

  Future<void> submitForm(BuildContext context) async {
    await _reviewService.addReview(
        customerId: _call!.customer.uid,
        providerId: _call!.provider!.uid,
        callId: _call!.callId,
        rating: _rating,
        desc: _desc);

    // update service call
    _serviceCallService.setIsReviewed(_call!.callId, true);
    _serviceCallService.setRating(_call!.callId, _rating);

    // update user profile
    num currRating = await _userService.getRating(_call!.provider!.uid);
    num reviewsCount = await _userService.getReviewsCount(_call!.provider!.uid);

    num newRating = ((currRating * (reviewsCount)) + (rating)) / ++reviewsCount;

    Map<String, dynamic> data = {
      'reviewsCount': ++reviewsCount,
      'rating': newRating
    };

    await _userService.updateUser(_call!.provider!.uid, data);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryPage()),
    );
  }
}
