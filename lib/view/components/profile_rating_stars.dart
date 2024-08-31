import 'package:flutter/material.dart';

Widget buildBoldTextWithStars(String label, {num? rating}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        if (label == 'Rating:' && rating != null)
          _buildStarRating(rating), // Display stars if label is 'Rating:'
      ],
    );
  }

  Widget _buildStarRating(num rating) {
    int fullStars = rating.floor();
    num halfStar = rating - fullStars;

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