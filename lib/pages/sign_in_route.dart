import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/pages/customer_welcome_page.dart';
//import 'package:help_app/pages/home_page.dart';
import 'package:help_app/pages/home_page_client.dart';
import 'package:help_app/pages/home_page_provider.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/pages/sign_in_page.dart';

class SignInAuth extends StatelessWidget {
  const SignInAuth({Key? key});

  Future<AppUser?> getCurrentUser(String uid) async {
    return await AppUser.getUserById(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // check if the user is provider or customer
            String uid = snapshot.data!.uid;
            return FutureBuilder<AppUser?>(
              future: getCurrentUser(uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Show a loading indicator while fetching user data
                }
                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }
                if (userSnapshot.hasData) {
                  AppUser? curr_user = userSnapshot.data;
                  if (curr_user != null && curr_user.type == 2) {
                    return const HomePageProvider();
                  } else if (curr_user != null && curr_user.type == 1) {
                    return const HomePageCustomer();
                  } else {
                    return const CustomerWelcomePage();
                  }
                } else {
                  return const SignInPage();
                }
              },
            );
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
