import 'package:flutter/material.dart';
import 'package:help_app/objects/review.dart';
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
  late Stream<DocumentSnapshot> _callStream = Stream.empty();
  Review? review;

  @override
  void initState() {
    super.initState();
    _callStream = FirebaseFirestore.instance
        .collection('service_calls')
        .doc(widget.call?.serviceCallId)
        .snapshots();

    getReview(widget.call).then((reviewData) {
      setState(() {
        review = reviewData;
      });
    });

    print("this ${review?.customerID}");
  }

  Future<Review?> getReview(ServiceCall? call) async {
    if (call?.isReviewed == true) {
      return await Review.getReviewCallById(call?.serviceCallId ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _callStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final Map<String, dynamic>? callData =
              snapshot.data?.data() as Map<String, dynamic>?;

          if (callData != null) {
            final bool isCompleted = callData['isCompleted'] ?? false;
            final bool isReviewed = callData['isReviewed'] ?? false;

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
                        _buildStatusIndicator(isCompleted),
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

                    // review field
                    (isReviewed && widget.role_type == 1)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("rating: ${review?.rating}"),
                              SizedBox(height: 10),
                              Text("review desc: ${review?.reviewDesc}"),
                            ],
                          )
                        : Container(),
                    // Render buttons based on conditions
                    _buildButtons(isCompleted, isReviewed),
                  ],
                ),
              ),
            );
          } else {
            return Text('No data available');
          }
        }
      },
    );
  }

  Widget _buildButtons(bool isCompleted, bool isReviewed) {
    if (!isCompleted && widget.role_type == 1) {
      return ElevatedButton(
        onPressed: () async {
          if (widget.call?.isCompleted == false) {
            await FirebaseFirestore.instance
                .collection('service_calls')
                .doc(widget.call?.serviceCallId)
                .update({
              'isCompleted': true,
              'providerID': ProviderId,
            });
          }
        },
        child: Text("Take Job"),
      );
    } else if (isCompleted && !isReviewed && widget.role_type == 2) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LeaveReviewPage(
                serviceCallId: widget.call!.serviceCallId.toString(),
              ),
            ),
          );
        },
        child: Text("Leave Review"),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildStatusIndicator(bool isCompleted) {
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
}
