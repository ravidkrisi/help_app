import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';

class CallCard extends StatelessWidget {
  final ServiceCall? call;

  const CallCard({required this.call, Key? key}) : super(key: key);

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