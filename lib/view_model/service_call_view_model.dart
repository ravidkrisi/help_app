import 'package:flutter/material.dart';
import 'package:help_app/model/service_call.dart';
import 'package:help_app/services/service_call_service.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/pages/home_page.dart';
import 'package:help_app/view_model/user_view_model.dart';

class ServiceCallViewModel extends ChangeNotifier {
  // view model
  UserViewModel _userViewModel;

  ServiceCallViewModel(this._userViewModel);

  final ServiceCallService _serviceCallService = ServiceCallService();
  final UserService _userService = UserService();
  // form fields
  TaskCategory _category = TaskCategory.etc;
  City _city = City.ashdod;
  String _desc = '';
  num _cost = 0;

  //design variables

  // setters
  set category(value) => _category = value;
  set city(value) => _city = value;
  set desc(value) => _desc = value;
  set cost(value) => _cost = double.parse(value);

  // getters
  TaskCategory get category => _category;
  City get city => _city;
  String get desc => _desc;
  num get cost => _cost;

  // add service call to firestore
  Future<void> submitForm(BuildContext context) async {
    await _serviceCallService.addServiceCall(
        _userViewModel.user!, category, city, desc, cost);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  // handle take job button
  Future<void> takeJob(String callId) async {
    try {
      String providerId = _userViewModel.user!.uid;

      // Update the providerId field in the service call document
      Map<String, dynamic> data = {
        'providerId': providerId,
        'inProgress': true,
      };
      await _serviceCallService.updateCall(callId, data);
    } catch (e) {
      print('Error setting provider: $e');
    }
  }

  // handle finished button
  Future<void> finishJob(ServiceCall call) async {
    try {
      // Update the providerId field in the service call document
      Map<String, dynamic> data = {
        'inProgress': false,
        'isCompleted': true,
      };
      await _serviceCallService.updateCall(call.callId, data);

      // get current user data
      num totalEarning =
          await _userService.getTotalEarning(_userViewModel.user!.uid);
      num rating = await _userService.getRating(_userViewModel.user!.uid);
      num callsCount =
          await _userService.getCallsCount(_userViewModel.user!.uid);
      num reviewsCount =
          await _userService.getCallsCount(_userViewModel.user!.uid);

      reviewsCount++;
      callsCount++;
      totalEarning = totalEarning + call.cost;
      rating =
          ((rating * (reviewsCount - 1)) + (call.rating ?? 0)) / reviewsCount;
      // update the user data
      data = {
        'inProgress': false,
        'isCompleted': true,
        'callsCount': callsCount,
        'totalEarning': totalEarning,
      };

      await _userService.updateUser(call.provider!.uid, data);
    } catch (e) {
      print('Error setting provider: $e');
    }
  }
}
