import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/widgets/call_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageCustomer extends StatefulWidget {
  const HomePageCustomer({Key? key}) : super(key: key);

  @override
  State<HomePageCustomer> createState() => HomePageCustomerState();
}

class HomePageCustomerState extends State<HomePageCustomer> {
  String selectedLocation = "All";
  int originalVisiblePostCount = 10;
  int visiblePostCount = 10;
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

  // async function to fetch all service calls
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
      print("fetched all service calls data successfully");
      print(allCalls[1]?.area);
    } catch (e) {
      print("error occured while fetching all service calls $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to your another screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ServiceCallPage(), // Replace with your actual screen
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      // top bar
      appBar: AppBar(
        title: Text("Posts"),
      ),

      // body
      body:
          // check if all data have fetched, else show progress bar
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    
                    // create calls feed
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredCalls.length,
                        itemBuilder: (context, index) {
                          if (filteredCalls.isNotEmpty) {
                            // Check if the call's location matches the selected location
                            return CallCard(call: filteredCalls[index]);
                          } else
                            return Container();
                        },
                      ),
                    ),
                  ],
                ),
      // bottom bar
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
          switch (index) {
            case 0:
              setState(() {
                filteredCalls = allCalls
                    .where((call) => call?.isCompleted == false)
                    .toList();
              });
              break;
            case 1:
              // Handle tapping on the Profile button
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProviderProfile(), // Replace with the actual ProfileProvider widget
                ),
              );
              break;
            case 2:
              setState(() {
                filteredCalls = allCalls
                    .where((call) => call?.isCompleted == true)
                    .toList();
              });
              break;
          }
        },
      ),
    );
  }

  // generate locations list from the allcalls
  List<String> getUniqueLocations() {
    Set<String> uniqueLocations = Set<String>();
    uniqueLocations.add("All");
    for (var call in allCalls) {
      uniqueLocations.add(call?.area ?? '');
    }

    return uniqueLocations.toList();
  }
}
