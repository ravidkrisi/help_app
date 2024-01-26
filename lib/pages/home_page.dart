import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/pages/welcom_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1st element show the user email address
          Text("signed in as ${user.email}"),
          // 2nd element button to log out 
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                // Call the asynchronous function and wait for it to complete
                context,
                MaterialPageRoute(
                  builder: (e) => const WelcomePage(),
                ),
              );
            },
            color: Colors.deepOrange,
            child: Text("sign out"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                // Call the asynchronous function and wait for it to complete
                context,
                MaterialPageRoute(
                  builder: (e) => const ServiceCallPage(),
                ),
              );
            },
            color: Colors.deepOrange,
            child: Text("create call"),
          )
        ],
      ),
    ));
  }
}
