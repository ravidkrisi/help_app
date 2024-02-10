import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/objects/provider_user.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/pages/customer_welcome_page.dart';
import 'package:help_app/pages/home_page_customer.dart';
import 'package:help_app/pages/home_page_provider.dart'; // Import HomePageProvider page

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  String? _uid;
  AppUser? _user;

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  Future<void> checkCurrentUser() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    print(userId);
    AppUser? customerUser = await AppUser.getUserById(userId!);

    if (userId.isNotEmpty) {
      setState(() {
        _uid = userId;
        _user = customerUser;
      });
    } else {
      print("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top bar
      appBar: AppBar(
        title: Text('Profile'),
      ),

      // main body
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // divider
                SizedBox(height: 20),

                // profile picture field
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue, // Change to blue
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),

                // divider
                SizedBox(height: 20),

                // name field
                Text(
                  _user?.name ?? 'NA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // divider
                SizedBox(height: 20), // Added space from top
              ],
            ),
          ),

          // divider
          const SizedBox(
            height: 80.0,
          ),

          // bottom navigator buttons bar
          Container(
            child: _buildBottomButtons(context),
          )
        ],
      ),
    );
  }

  Widget _buildBoldText(String label, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to HomePageProvider
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageCustomer()),
            );
          },
          child: Column(
            children: [
              Icon(Icons.home, size: 30),
              Text('Home'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _signOut(context);
          },
          child: Column(
            children: [
              Icon(Icons.logout, size: 30),
              Text('Log out'),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the sign-in page after successful logout
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              CustomerWelcomePage(), // Replace SignInPage with your actual sign-in page widget
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
      // Handle error signing out, if any
    }
  }
}
