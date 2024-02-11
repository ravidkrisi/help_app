import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/pages/home_page_provider.dart';
import 'package:help_app/pages/home_page_customer.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/pages/provider_history.dart';
import 'package:help_app/pages/customer_profile.dart';
import 'package:help_app/pages/customer_history.dart';

class BottomNavigationTemplate extends StatelessWidget {
  final String userId; // User ID

  const BottomNavigationTemplate({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return Text('No data available');
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final int roleType = userData['type'];

        // Build the bottom navigation based on the user's role type
        return Scaffold(
          body:
              Placeholder(), // Replace Placeholder with your desired body content
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue, // Color for the selected item
            unselectedItemColor: Colors.grey, // Color for unselected items
            showUnselectedLabels: true, // Show labels for unselected items
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => roleType == 1
                          ? HomePageProvider()
                          : HomePageCustomer(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          roleType == 1 ? ProviderProfile() : CustomerProfile(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => roleType == 1
                          ? ProviderHistoryPage(customerId: userId)
                          : HistoryPage(),
                    ),
                  );
                  break;
              }
            },
          ),
        );
      },
    );
  }
}
