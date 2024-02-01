import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/widgets/call_card.dart';

class HomePageProvider extends StatefulWidget {
  const HomePageProvider({Key? key}) : super(key: key);

  @override
  State<HomePageProvider> createState() => HomePageProviderState();
}

class HomePageProviderState extends State<HomePageProvider> {
  String selectedLocation = "All";
  int originalVisiblePostCount = 10;
  int visiblePostCount = 10;
  bool _isLoading = true;

  List<ServiceCall?> allCalls = [];

  // set state when build the page
  @override
  void initState() {
    super.initState();
    fetchCalls();
  }

  // async function to fetch all service calls
  Future<void> fetchCalls() async {
    try {
      List<ServiceCall?> calls = await ServiceCall.getAllPosts();
      setState(() {
        allCalls = calls;
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
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // location filter
                          Text("Location: "),
                          DropdownButton<String>(
                            value: selectedLocation,
                            items: getUniqueLocations().map((location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedLocation = value!;
                                visiblePostCount = originalVisiblePostCount;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    // create calls feed
                    Expanded(
                      child: ListView.builder(
                        itemCount: allCalls.length,
                        itemBuilder: (context, index) {
                          // Check if the call's location matches the selected location
                          if (selectedLocation == "All" ||
                              allCalls[index]?.area == selectedLocation) {
                            return CallCard(call: allCalls[index]);
                          } else {
                            // Return an empty container if the location doesn't match
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
      // bottom bar
      bottomNavigationBar: BottomNavigationBar(
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
          switch (index) {
    case 0:
      // Handle tapping on the Home button if needed
      break;
    case 1:
      // Handle tapping on the Profile button
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProviderProfile(), // Replace with the actual ProfileProvider widget
        ),
      );
      break;
    case 2:
      // Handle tapping on the History button if needed
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
