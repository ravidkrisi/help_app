import 'package:flutter/material.dart';
import 'package:help_app/services/auth_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/utils/result.dart';
import 'package:help_app/view/pages/home_page.dart';
import 'package:help_app/view/pages/sign_up_page.dart';
import 'package:help_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthService _auth = AuthService();
  final UserViewModel _userViewModel;

  String _email = '';
  String _password = '';

  // constructor
  SignInViewModel(this._userViewModel);

  // getter
  UserType get type => _userViewModel.type;

  // setters
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  // function to handle log in
  Future<void> logIn(BuildContext context) async {
    Stream<Result<AppUser>> stream =
        _auth.signInWithEmailAndPassword(_email, _password);

    stream.listen((Result<AppUser> result) {
      if (result.isSuccess) {
        _userViewModel.setUser(result.value!.uid);
        // navigate to home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(), // Replace with the actual ProfileProvider widget
          ),
        );
      }
    });

    // // login succeed
    // if (result!.isSuccess) {
    //   // set userViewModel to current user
    //   _userViewModel.setUser(result.value!);
    //   // navigate to home page
    //   Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         HomePage(), // Replace with the actual ProfileProvider widget
    //   ),
    // );

    // }
    notifyListeners();
  }

  // // fucntion to check if a user is already logged in
  // Future<void> isUserLoggedIn(BuildContext context) async {
  //   Result<AppUser?>? result = await _auth.isUserLoggedIn();

  //   // if user is logged in navigate to home page
  //   if (result != null) {
  //     if (result.isSuccess) {
  //       // Navigator.pushNamed(context, RouteNames.home);
  //       Navigator.push(
  //         context, // Use the BuildContext provided during widget creation
  //         MaterialPageRoute(
  //           builder: (context) => HomePage(),
  //         ),
  //       );
  //     }
  //   }

  //   // user not logged in, navigate to welcome page
  //   else {
  //     // Navigator.pushNamed(context, RouteNames.signUp);
  //     Navigator.push(
  //       context, // Use the BuildContext provided during widget creation
  //       MaterialPageRoute(
  //         builder: (context) => SignUpPage(
  //           userType: type,
  //         ),
  //       ),
  //     );
  //   }
  // }

  UserType getType(BuildContext context) {
    return Provider.of<UserViewModel>(context).type;
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
