import 'package:flutter/material.dart';
import 'package:help_app/view/pages/sign_in_page.dart';

void openSignInScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignInPage()));
}
