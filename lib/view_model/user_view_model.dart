import 'package:flutter/material.dart';
import 'package:help_app/model/user.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/utils/result.dart';

class UserViewModel extends ChangeNotifier {
  AppUser? _user;
  UserType _type = UserType.customer;
  final UserService _userService = UserService();

  // getters
  AppUser? get user => _user;
  UserType get type => _type;

  // Get the rating only if the user is a ProviderUser
  Future<num> get rating async {
    if (_user is ProviderUser) {
      return await _userService.getRating(_user!.uid);
    }
    throw Exception("user not valid or provider");
  }

  // Get the totalEarning only if the user is a ProviderUser
  Future<num> get totalEarning async {
     if (_user is ProviderUser) {
      return await _userService.getTotalEarning(_user!.uid);
    }
    throw Exception("user not valid or provider");
  }

  // Get the callsCount only if the user is a ProviderUser
  Future<num> get callsCount async {
     if (_user is ProviderUser) {
      return await _userService.getCallsCount(_user!.uid);
    }
    throw Exception("user not valid or provider");
  }

  // // setter
  // void setUser(AppUser user) {
  //   // deep copy
  //   _user = AppUser.fromJson(user.toJson());
  //   _type = _user!.type;
  //   notifyListeners();

  // }
  // // setter
  // void setUser(AppUser user) {
  //   // deep copy
  //   _user = AppUser.fromJson(user.toJson());
  //   _type = _user!.type;
  //   notifyListeners();

  // }

  // setter
  void setUser(String userId) async {
    Result<AppUser> user = await _userService.getUserById2(userId);
    _user = user.value;
    _type = user.value!.type;
    notifyListeners();
  }

  // handle the swtich of user type
  void switchUserType() {
    if (_type == UserType.customer) {
      _type = UserType.provider;
    } else if (_type == UserType.provider) {
      _type = UserType.customer;
    }
    notifyListeners();
  }
}
