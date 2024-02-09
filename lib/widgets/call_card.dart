import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/pages/review_page.dart'; // Import LeaveReviewPage

String? ProviderId = FirebaseAuth.instance.currentUser?.uid;

class CallCard extends StatefulWidget {
  final ServiceCall? call;
  final int role_type; // 0: non btn 1: 'take job 2:'leave review'

  const CallCard({required this.call, required this.role_type, Key? key})
      : super(key: key);

  @override
  _CallCardState createState() => _CallCardState();
}

class _CallCardState extends State<CallCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error fetching user type: ${snapshot.error}');
          return Text('Error fetching user type');
        } else {
          final userType = snapshot.data;
          print('User type: $userType');
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
                      _buildStatusIndicator(widget.call?.isCompleted),
                      SizedBox(width: 8),
                      Text(
                        widget.call?.category ?? '',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Location: ${widget.call?.area}"),
                  SizedBox(height: 10),
                  Text("Price: \$${widget.call?.cost}"),
                  SizedBox(height: 25),
                  Text(widget.call?.description ?? ''),
                  SizedBox(height: 16),

                  // if (widget.call?.isCompleted == true ||
                  //     userType == 1) // Add condition to show Review button
                  //   ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => LeaveReviewPage(
                  //               serviceCallId:
                  //                   widget.call!.serviceCallId.toString()),
                  //         ),
                  //       );
                  //     },
                  //     child: Text("Review"),
                  //   ),

                  // take job
                  (widget.call?.isCompleted != true && widget.role_type == 1)
                      ? ElevatedButton(
                          onPressed: widget.call?.isCompleted == true
                              ? null
                              : () async {
                                  if (widget.call?.isCompleted == false) {
                                    await FirebaseFirestore.instance
                                        .collection('service_calls')
                                        .doc(widget.call?.serviceCallId)
                                        .update({
                                      'isCompleted': true,
                                      'providerID': ProviderId,
                                    });
                                    _buildStatusIndicator(
                                        widget.call?.isCompleted);
                                    print(
                                        "Take Job button pressed for ${widget.call?.category}");
                                  }
                                },
                          child: Text("Take Job"),
                        )

                      // leave review button
                      : (widget.call?.isCompleted == true &&
                              widget.role_type == 2 &&
                              widget.call?.isReviewed == false)
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeaveReviewPage(
                                        serviceCallId: widget
                                            .call!.serviceCallId
                                            .toString()),
                                  ),
                                );
                              },
                              child: Text("leave review"),
                            )
                          : (widget.call?.isCompleted == true &&
                                  widget.role_type == 2 &&
                                  widget.call?.isReviewed == true)
                              ? ElevatedButton(
                                  onPressed: () {
                                    // handle this review button
                                  },
                                  child: Text("see review"),
                                )
                              // else no button
                              : Container(),
                ],
              ),
            ),
          );
        }
      },
    );
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
