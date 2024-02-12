import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/objects/provider_user.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/widgets/call_card.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/pages/customer_welcome_page.dart';
import 'package:help_app/pages/home_page_provider.dart'; // Import HomePageProvider page
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:help_app/objects/service_call.dart';
import 'package:help_app/widgets/custom_bottom_bar.dart';

String? userId = FirebaseAuth.instance.currentUser?.uid;

class ProviderHistoryPage extends StatefulWidget {
  const ProviderHistoryPage({Key? key}) : super(key: key);

  @override
  State<ProviderHistoryPage> createState() => _ProviderHistoryPageState();
}

class _ProviderHistoryPageState extends State<ProviderHistoryPage> {
  bool _isLoading = true;
  List<ServiceCall?> allCalls = [];
  List<ServiceCall?> filteredCalls = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchCalls();
  }

  Future<void> fetchCalls() async {
    try {
      String? currId = FirebaseAuth.instance.currentUser?.uid;
      List<ServiceCall?> calls = await ServiceCall.getAllPosts();

      calls = calls
          .where((call) =>
              call?.isCompleted == true && call?.provider?.userId == currId)
          .toList();

      print(calls.length);
      setState(() {
        allCalls = calls;
        _isLoading = false;
        userId = currId;
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
                        role_type: 1,
                      );
                    },
                  ),
        bottomNavigationBar:
            CustomBottomNavigationBar(userType: 1, currentIndex: 2));
  }
}
