import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';

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
                            return PostCard(call: allCalls[index]);
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
          // Handle tapping on the bottom navigation bar items if needed
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

class PostCard extends StatelessWidget {
  final ServiceCall? call;

  const PostCard({required this.call, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget representing a card for displaying service call information
    return Card(
      elevation: 5, // Add a shadow effect to the card
      margin: EdgeInsets.all(16), // Add space around the card
      child: Padding(
        padding: EdgeInsets.all(16), // Add padding to the contents of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for displaying status indicator and category
            Row(
              children: [
                _buildStatusIndicator(
                    call?.isCompleted), // Display status indicator
                SizedBox(
                    width:
                        8), // Add a small space between status indicator and category
                Text(
                  call?.category ??
                      '', // Display the category of the service call
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight
                          .bold), // Apply styling to the category text
                ),
              ],
            ),
            SizedBox(height: 10), // Add vertical spacing
            Text(
                "Location: ${call?.area}"), // Display the location of the service call
            SizedBox(height: 10), // Add vertical spacing
            Text(
                "isOpen: ${call?.isCompleted}"), // Display whether the call is open or not
            SizedBox(height: 10), // Add vertical spacing
            Text(
                "Price: \$${call?.cost}"), // Display the cost of the service call
            SizedBox(height: 25), // Add vertical spacing
            Text(call?.description ??
                ''), // Display the description of the service call
            SizedBox(height: 16), // Add vertical spacing
            // Elevated button for taking the job
            ElevatedButton(
              onPressed: () {
                // Callback function when the "Take Job" button is pressed
                print("Submit Offer button pressed for ${call?.category}");
              },
              child: Text("Take Job"), // Text on the button
            ),
          ],
        ),
      ),
    );
  }

// Helper method for building a status indicator based on isOpen
  Widget _buildStatusIndicator(bool? isOpen) {
    Color ind_color = Colors.black; // Default color for the status indicator

    // Check the value of isOpen and set the color accordingly
    if (isOpen == null) {
      ind_color = Colors.grey; // Grey for null
    } else if (isOpen == true) {
      ind_color = Colors.green; // Green for true
    } else if (isOpen == false) {
      ind_color = Colors.red; // Red for false
    }

    // Return a circular status indicator with the determined color
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ind_color,
      ),
    );
  }
}
