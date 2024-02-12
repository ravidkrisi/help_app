import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/pages/profile_customer.dart';
import 'package:help_app/pages/profile_provider.dart';
import 'package:help_app/pages/history_customer.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/widgets/call_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/widgets/custom_bottom_bar.dart';
import 'package:help_app/widgets/custom_bottom_bar.dart';

class HomePageCustomer extends StatefulWidget {
  const HomePageCustomer({Key? key}) : super(key: key);

  @override
  State<HomePageCustomer> createState() => HomePageCustomerState();
}

class HomePageCustomerState extends State<HomePageCustomer> {
  bool _isLoading = true;
  int _selectedIndex = 0; // Add this variable to track the selected item index

  List<ServiceCall?> allCalls = [];
  List<ServiceCall?> filteredCalls = [];

// set state when build the page
  @override
  void initState() {
    super.initState();
    fetchCalls();
  }

  Future<void> fetchCalls() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    try {
      List<ServiceCall?> calls = await ServiceCall.getAllCustomerPosts(userId!);
      setState(() {
        allCalls = calls;
        filteredCalls =
            allCalls.where((call) => call?.isCompleted == false).toList();
        _isLoading = false;
      });
      print("fetched all service calls data successfully ${userId!}");
    } catch (e) {
      print("error occurred while fetching all service calls $e");
    }
  }

  Future<void> _refreshHomePage() async {
    setState(() {
      _isLoading = true;
    });
    await fetchCalls();
    setState(() {
      _isLoading = false;
    });
  }

  // void _addServiceCall() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ServiceCallPage(),
  //     ),
  //   ).then((_) {
  //     // Reload the calls after returning from the ServiceCallPage
  //     fetchCalls();
  //   });
  // }

  // void _navigateToServiceCallPage() async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ServiceCallPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _refreshHomePage,
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body:

          // fetch customer open calls
          _isLoading
              ? Center(child: CircularProgressIndicator())

              // case 1: no open calls
              : filteredCalls.isEmpty
                  ? Center(
                      child: Text(
                        'create new call',
                        style: TextStyle(fontSize: 24),
                      ),
                    )

                  // case 2: create open calls queue
                  : ListView.builder(
                      itemCount: filteredCalls.length,
                      itemBuilder: (context, index) {
                        if (filteredCalls.isNotEmpty) {
                          // Check if the call's location matches the selected location
                          return CallCard(
                              call: filteredCalls[index], role_type: 2);
                        } else
                          return Container();
                      },
                    ),
      // bottomNavigationBar: BottomNavigationTemplate(
      //   userId: FirebaseAuth.instance.currentUser!.uid,
      // ),
      // bottom buttons bar
      bottomNavigationBar: CustomBottomNavigationBar(
        userType: 2,
        currentIndex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceCallPage()),
        ), // Update onPressed handler
        tooltip: 'Add Post',
        child: Icon(Icons.add),
      ),
    );
  }
}
