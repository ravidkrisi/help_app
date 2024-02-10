import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/pages/customer_profile.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/pages/customer_history.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/widgets/call_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  void initState() {
    super.initState();
    fetchCalls();
  }

  @override
  void didUpdateWidget(covariant HomePageCustomer oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchCalls(); // Fetch calls whenever the widget updates
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

  void _addServiceCall() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceCallPage(),
      ),
    ).then((_) {
      // Reload the calls after returning from the ServiceCallPage
      fetchCalls();
    });
  }

  void _navigateToServiceCallPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ServiceCallPage()),
    );

    // Check if the result is not null and trigger data refresh
    if (result != null) {
      print("not null");
      fetchCalls();
    }
  }

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
              : allCalls.isEmpty
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

      // bottom buttons bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        currentIndex: _selectedIndex,
        items: [
          // home button
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          // profile button
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

          // history button
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],

        // bottom bar tap actions
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageCustomer(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerProfile(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ),
              );
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToServiceCallPage, // Update onPressed handler
        tooltip: 'Add Post',
        child: Icon(Icons.add),
      ),
    );
  }
}
