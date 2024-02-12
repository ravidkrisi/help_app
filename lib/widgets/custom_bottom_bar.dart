import 'package:flutter/material.dart';
import 'package:help_app/pages/history_customer.dart';
import 'package:help_app/pages/profile_customer.dart';
import 'package:help_app/pages/home_page_customer.dart';
import 'package:help_app/pages/home_page_provider.dart';
import 'package:help_app/pages/history_provider.dart';
import 'package:help_app/pages/profile_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int userType;
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key? key,
    required this.userType,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      currentIndex: currentIndex,
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

            // customer user
            if (userType == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageCustomer(),
                ),
              );
            }

            // provider user
            if (userType == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageProvider(),
                ),
              );
            }
            break;
          case 1:

            // customer user
            if (userType == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerProfile(),
                ),
              );
            }

            // provider user
            else if (userType == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderProfile(),
                ),
              );
            }
            break;
          case 2:

            // customer user
            if (userType == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerHistoryPage(),
                ),
              );
            }

            // provider user
            else if (userType == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderHistoryPage(),
                ),
              );
            }
            break;
        }
      },
    );
  }
}
