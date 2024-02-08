import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/pages/review_page.dart'; // Import LeaveReviewPage

String? ProviderId = FirebaseAuth.instance.currentUser?.uid;

class CallCard extends StatefulWidget {
  final ServiceCall? call;

  const CallCard({required this.call, Key? key}) : super(key: key);

  @override
  _CallCardState createState() => _CallCardState();
}

class _CallCardState extends State<CallCard> {
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
                "Price: \$${call?.cost}"), // Display the cost of the service call
            SizedBox(height: 25), // Add vertical spacing
            Text(call?.description ??
                ''), // Display the description of the service call
            SizedBox(height: 16), // Add vertical spacing
          ],
        ),
      ),
    );
  }
}

  Widget _buildStatusIndicator(bool? isCompleted) {
    Color ind_color = Colors.black;
    if (isCompleted == null) {
      ind_color = Colors.grey;
    } else if (isCompleted == true) {
      ind_color = Colors.red;
    } else if (isCompleted == false) {
      ind_color = Colors.green;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ind_color,
      ),
    );
  }

  Future<int?> getUserType() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final idTokenResult = await user.getIdTokenResult();
        final Map<String, dynamic>? claims = idTokenResult.claims;
        return claims?['type'] as int?;
      }
    } catch (e) {
      print('Error getting user type: $e');
    }
    return null;
  }
}
