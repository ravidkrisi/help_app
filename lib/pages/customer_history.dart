import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/objects/provider_user.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/widgets/call_card.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/pages/customer_welcome_page.dart';
import 'package:help_app/pages/home_page_customer.dart'; // Import HomePageProvider page
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:help_app/objects/service_call.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLoading = true;
  List<ServiceCall?> allCalls = [];

  @override
  void initState() {
    super.initState();
    fetchCalls();
  }

  Future<void> fetchCalls() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      List<ServiceCall?> calls = await ServiceCall.getAllCustomerPosts(userId!);
      calls = calls.where((call) => call?.isCompleted == true).toList();
      setState(() {
        allCalls = calls;
        _isLoading = false;
      });
      print("fetched all service calls data successfully");
    } catch (e) {
      print("error occurred while fetching all service calls $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: fetchCalls,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : allCalls.isEmpty
              ? Center(
                  child: Text(
                    'No completed service calls found.',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              : ListView.builder(
                  itemCount: allCalls.length,
                  itemBuilder: (context, index) {
                    return CallCard(
                      call: allCalls[index],
                      role_type: 2,
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
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
              // Handle tapping on the Home button if needed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageCustomer(),
                ),
              );
              break;
            case 1:
              // Handle tapping on the Profile button
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderProfile(),
                ),
              );
              break;
            case 2:
              // Handle tapping on the History button
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
