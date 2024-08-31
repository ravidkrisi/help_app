// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:help_app/model/service_call.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/pages/leave_review_page.dart';
import 'package:help_app/view_model/service_call_view_model.dart';
import 'package:provider/provider.dart';

class CallCard extends StatelessWidget {
  final ServiceCall call;
  final int btn_type;

  const CallCard({required this.call, required this.btn_type, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceCallViewModel>(
      builder: (context, serviceCallViewModel, _) {
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
                    _buildStatusIndicator(call.isCompleted, call.inProgress),
                    SizedBox(width: 8),
                    Text(
                      enumToString(
                          call.category), // Assuming category is an enum
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                    "Location: ${enumToString(call.city)}"), // Assuming city is an enum
                SizedBox(height: 10),
                Text("Price: \$${call.cost}"),
                SizedBox(height: 25),
                Text(call.desc),
                // Render buttons based on conditions
                _buildButtons(
                    call.isCompleted, call, serviceCallViewModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtons(bool isCompleted, ServiceCall call,
      ServiceCallViewModel serviceCallViewModel, BuildContext context) {
    // take job
    if (btn_type == 1) {
      return ElevatedButton(
        onPressed: () {
          serviceCallViewModel.takeJob(call.callId);
        },
        child: Text("Take Job"),
      );
    }

    // leave review
    else if (btn_type == 2) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LeaveReviewPage(call: call)),
          );
        },
        child: Text("Leave Review"),
      );
    }

    // finish job button
    else if (btn_type == 3) {
      return ElevatedButton(
        onPressed: () {
          serviceCallViewModel.finishJob(call);
        },
        child: Text("finish job"),
      );
    }
    return SizedBox
        .shrink(); // Return an empty SizedBox if no buttons are needed
  }

  Widget _buildStatusIndicator(bool isCompleted, bool inProgress) {
    Color ind_color = Colors.black;
    if (isCompleted) {
      ind_color = Colors.red;
    } else if (inProgress) {
      ind_color = Colors.yellow;
    } else {
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
