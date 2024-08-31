import 'package:flutter/material.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/pages/sign_in_page.dart';
import 'package:help_app/view/pages/sign_up_page.dart';
import 'package:help_app/view_model/user_view_model.dart';

class WelcomePageViewModel extends ChangeNotifier {
  final UserViewModel _userViewModel;
  String _typeButtonLabel = "Are you a provider?\n Click here";

  WelcomePageViewModel(this._userViewModel);

  // getters
  // get userType => _userType;
  get typeButtonLabel => _typeButtonLabel;

  // handle the swtich of user type
  void switchUserType() {
    if (_userViewModel.type == UserType.customer) {
      _userViewModel.switchUserType();
      _typeButtonLabel = "Are you a Customer?\n Click here";
    } else if (_userViewModel.type == UserType.provider) {
      _userViewModel.switchUserType();
      _typeButtonLabel = "Are you a Provider?\n Click here";
    }
    notifyListeners();
  }

  void navigateToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SignInPage(), // Replace with the actual ProfileProvider widget
      ),
    );
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SignUpPage(), // Replace with the actual ProfileProvider widget
      ),
    );
  }
}
