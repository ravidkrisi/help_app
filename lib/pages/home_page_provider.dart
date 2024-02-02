import 'package:flutter/material.dart';

class Post {
  String title = "";
  String content = "";
  String location = "";
  int price = 1;
  bool isOpen = false;

  Post(this.title, this.content, this.location, this.price, this.isOpen);
}

List<Post> posts = [
  Post("First Post", "This is my first post , Helloooo!!!", "Rosh Haayin", 50,
      true),
  Post("Second Post", "This is my second post , Helloooo!!!", "Tel Aviv", 20,
      false),
  Post("Third Post", "This is my third post", "Bat Yam", 15, true),
  Post("Fourth Post", "This is my fourth post ", "Ariel", 100, false),
  Post("fifth Post", "This is my fifth post , Helloooo!!!", "Rosh Haayin", 50,
      true),
  Post("sixth Post", "This is my sixth post , Helloooo!!!", "Tel Aviv", 20,
      false),
  Post("seventh Post", "This is my seventh post", "Bat Yam", 15, true),
  Post("hello", "This is my  post ", "Ariel", 100, false),
  Post("My", "This is my post , Helloooo!!!", "Rosh Haayin", 50, true),
  Post("Name", "This is my post , Helloooo!!!", "Tel Aviv", 20, false),
  Post("Is", "This is my post", "Bat Yam", 15, true),
  Post("Ruth", "This is my post ", "Ariel", 100, false),
  // Add more posts as needed
];

class HomePageProvider extends StatefulWidget {
  const HomePageProvider({Key? key}) : super(key: key);

  @override
  State<HomePageProvider> createState() => HomePageProviderState();
}

class HomePageProviderState extends State<HomePageProvider> {
  String selectedLocation = "All";
  int originalVisiblePostCount = 10;
  int visiblePostCount = 10;

  @override
  Widget build(BuildContext context) {
    List<Post> filteredPosts = selectedLocation == "All"
        ? posts
        : posts.where((post) => post.location == selectedLocation).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
          Expanded(
            child: ListView.builder(
              itemCount: visiblePostCount + 1,
              // Ensure that the item count doesn't exceed the actual number of items
              itemBuilder: (context, index) {
                if (index == visiblePostCount) {
                  // Load More / Load Less button
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (visiblePostCount < filteredPosts.length) {
                          visiblePostCount +=
                              10; // Increase visible post count by 10
                          if (visiblePostCount > filteredPosts.length) {
                            // Ensure not to exceed the actual number of items
                            visiblePostCount = filteredPosts.length;
                          }
                        } else {
                          // If all posts are visible, reset visible post count to the original value
                          visiblePostCount = originalVisiblePostCount;
                        }
                      });
                    },
                    child: Text(
                      visiblePostCount < filteredPosts.length
                          ? "Load More"
                          : "Load Less",
                    ),
                  );
                }
                return PostCard(post: filteredPosts[index]);
              },
            ),
          ),
        ],
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
          // Handle tapping on the bottom navigation bar items if needed
        },
      ),
    );
  }

  List<String> getUniqueLocations() {
    Set<String> uniqueLocations = Set<String>();
    uniqueLocations.add("All");
    for (var post in posts) {
      uniqueLocations.add(post.location);
    }

    return uniqueLocations.toList();
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusIndicator(post.isOpen),
                SizedBox(width: 8),
                Text(
                  post.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Location: ${post.location}"),
            SizedBox(height: 10),
            Text("isOpen: ${post.isOpen}"),
            SizedBox(height: 10),
            Text("Price: \$${post.price}"),
            SizedBox(height: 25),
            Text(post.content),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print("Submit Offer button pressed for ${post.title}");
              },
              child: Text("Take Job"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(bool isOpen) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOpen ? Colors.green : Colors.red,
      ),
    );
  }
}
