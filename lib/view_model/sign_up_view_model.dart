import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_app/model/user.dart';
import 'package:help_app/services/auth_service.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/utils/result.dart';
import 'package:help_app/view/pages/home_page.dart';
import 'package:help_app/view_model/user_view_model.dart';

class SignUpViewModel extends ChangeNotifier {
  // services
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  final UserViewModel _userViewModel;

  // constrctor
  SignUpViewModel(this._userViewModel);

  // form text controllers
  String _email = '';
  String _password = '';
  String _name = '';
  UserType _userType = UserType.customer;

  // form dynamic design
  Color _nameBorderColor = Colors.black26;
  Color _emailBorderColor = Colors.black26;
  Color _passwordBorderColor = Colors.black26;

  // setters
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setUserType(UserType value) {
    _userType = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  // getters
  Color get nameBorderColor => _nameBorderColor;
  Color get emailBorderColor => _emailBorderColor;
  Color get passwordBorderColor => _passwordBorderColor;
  UserType get userType => _userType;

  // handle the swtich of user type
  void switchUserType() {
    if (_userType == UserType.customer) {
      _userType = UserType.provider;
    } else if (_userType == UserType.provider) {
      _userType = UserType.customer;
    }
    notifyListeners();
  }

  // handle the sign up
  Future<void> signUpUser(BuildContext context) async {
    Result<User> authResult = await _authService.signUp(_email, _password);

    // authentication went successfully
    if (authResult.isSuccess) {
      String uid = authResult.value!.uid;
      // add user to 'users' collection
      Map<String, dynamic> json = {
        'uid': uid,
        'email': _email,
        'name': _name,
        'userType': _userType,
        'rating': 0,
        'callsCount': 0,
        'reviewsCount': 0, 
        'totalEarning': 0,
      };
      AppUser newUser = AppUser.fromJson(json);
      Result<AppUser> result = await _userService.addUserToFirestore(newUser);
      if (result.isSuccess) {
        // set user UserViewModel to current user
        _userViewModel.setUser(result.value!.uid);

        Navigator.push(
          context, // Use the BuildContext provided during widget creation
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }
    notifyListeners();
  }
}
