import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/home_page.dart';
import 'package:help_app/pages/home_page_client.dart';
import 'package:help_app/pages/home_page_provider.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/pages/sign_in_page.dart';

class SignInAuth extends StatelessWidget {
  const SignInAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePageCustomer();
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
