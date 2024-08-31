import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_app/model/service_call.dart';
import 'package:help_app/services/service_call_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view_model/user_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final ServiceCallService _serviceCallService = ServiceCallService();

  UserViewModel _userViewModel;

  // constructor
  HomeViewModel(this._userViewModel) {
    // _serviceCallService.getAllServiceCallsStream().listen((List<ServiceCall> calls) {
    //   allCalls = calls;
    // });
    _serviceCallService.getAllOpenServiceCallsStream();
  }

  // screen handlers
  bool _isLoading = false;
  List<ServiceCall> allCalls = [];
  List<ServiceCall> filteredCalls = [];

  // getters
  bool get isLoading => this._isLoading;
  List<ServiceCall> get getFilteredCalls => this.filteredCalls;
  List<ServiceCall> get getAllCalls => this.allCalls;

  Future<int> getServiceCallsCount() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('service_calls').get();

    return querySnapshot.size;
  }

  // return user type
  UserType getUserType() {
    return _userViewModel.type;
  }

  // setters
  set isLoading(value) => this._isLoading = value;
  set setAllCalls(allCalls) => this.allCalls = allCalls;
  set setFilteredCalls(filteredCalls) => this.filteredCalls = filteredCalls;
}
