import 'package:flutter/material.dart';

class ServiceProvider {
  final String fullName;
  final String lineOfBusiness;
  final String areaOfOccupation;
  final double rating;
  final String recommendations;

  ServiceProvider({
    required this.fullName,
    required this.lineOfBusiness,
    required this.areaOfOccupation,
    required this.rating,
    required this.recommendations,
  });
}

ServiceProvider first = ServiceProvider(
  fullName: "Maya",
  lineOfBusiness: "Beauty",
  areaOfOccupation: "Tel Aviv",
  rating: 4.5,
  recommendations: "Very Good",
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Provider Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ServiceProviderProfilePage(),
    );
  }
}

class ServiceProviderProfilePage extends StatelessWidget {
  const ServiceProviderProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Provider Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Added space from top
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue, // Change to blue
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 80,
              ),
            ),
            SizedBox(height: 20),
            Text(
              first.fullName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildBoldTextWithStars('Line of Business:', first.lineOfBusiness),
            SizedBox(height: 10),
            _buildBoldTextWithStars(
                'Area of Occupation:', first.areaOfOccupation),
            SizedBox(height: 10),
            _buildBoldTextWithStars(
                'Rating:', '${first.rating}'), // Changed here
            SizedBox(height: 10),
            _buildBoldTextWithStars('Recommendations:', first.recommendations),
            SizedBox(height: 20), // Added space from top
            _buildBottomButtons(context), // Added bottom buttons
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    int fullStars = rating.floor();
    double halfStar = rating - fullStars;

    List<Widget> stars = [];

    // Add full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow));
    }

    // Add half star if necessary
    if (halfStar > 0) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow));
      fullStars++; // Increment fullStars to account for the half star
    }

    // Add empty stars to complete 5 stars
    for (int i = fullStars; i < 5; i++) {
      stars
          .add(Icon(Icons.star_border, color: Colors.grey)); // Empty star color
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }

  Widget _buildBoldText(String label, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildBoldTextWithStars(String label, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(width: 5),
        if (label == 'Rating:')
          _buildStarRating(
              double.parse(text)), // Display stars if label is 'Rating:'
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            // Handle tapping the home button
            // You can navigate to the home screen here
          },
          child: Column(
            children: [
              Icon(Icons.home, size: 30),
              Text('Home'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle tapping the search button
            // You can implement search functionality here
          },
          child: Column(
            children: [
              Icon(Icons.search, size: 30),
              Text('Search'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle tapping the profile button
            // You can navigate to the user's profile screen here
          },
          child: Column(
            children: [
              Icon(Icons.person, size: 30),
              Text('Profile'),
            ],
          ),
        ),
      ],
    );
  }
}
