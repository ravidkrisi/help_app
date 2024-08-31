import 'package:flutter/material.dart';
import 'package:help_app/services/auth_service.dart';
import 'package:help_app/view/pages/welcome_page.dart';
import 'package:help_app/view_model/user_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserViewModel userViewModel;
  final AuthService _authService = AuthService();

  ProfileViewModel(this.userViewModel);

  // function to sign out 
  Future<void> signOut(BuildContext context) async {
    try {
      await _authService.signOut();
      // Navigate to the sign-in page after successful logout
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              WelcomePage(), // Replace SignInPage with your actual sign-in page widget
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
      // Handle error signing out, if any
    }
  }


}
