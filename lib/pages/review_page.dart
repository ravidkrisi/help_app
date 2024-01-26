import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/widgets/custom_scaffold.dart';

class LeaveReviewPage extends StatefulWidget {
  final String serviceCallId;

  const LeaveReviewPage({Key? key, required this.serviceCallId})
      : super(key: key);

  @override
  _LeaveReviewPageState createState() => _LeaveReviewPageState();
}

class _LeaveReviewPageState extends State<LeaveReviewPage> {
  // set variables
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ServiceCall? serviceCall;

  // called only once when the widget is created
  @override
  void initState() {
    super.initState();
    _loadServiceCall();
  }

  Future<void> _loadServiceCall() async {
    // Call getServiceCallById to retrieve service call information
    serviceCall = await ServiceCall.getServiceCallById(widget.serviceCallId);

    // Trigger a rebuild after getting the data
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // set variable to get the size of screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // rating set
    List<int> ratings = [1, 2, 3, 4, 5];

    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _fbKey,
            // decoration for the form box
            child: Container(
              height: screenHeight * 2 / 3,
              padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 249, 249),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: const Color.fromARGB(255, 225, 160, 155),
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in the x, y direction
                  ),
                ],
              ),

              // starting the form fields
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 1st field: category
                  Text(
                    "category: ${serviceCall?.category}\n",
                    style: const TextStyle(fontSize: 18),
                  ),

                  // 2nd field: description
                  Text(
                    "description:\n ${serviceCall?.description}\n",
                    style: const TextStyle(fontSize: 18),
                  ),

                  // 3rd field: cost
                  Text(
                    "cost: ${serviceCall?.cost}\n",
                    style: const TextStyle(fontSize: 18),
                  ),

                  // 4th field: provider
                  Text(
                    "provider: ${serviceCall?.provider?.name}\n",
                    style: const TextStyle(fontSize: 18),
                  ),

                  // 5th field: rating from 1-5
                  FormBuilderDropdown(
                    name: 'rating',
                    // set decoration
                    decoration: const InputDecoration(labelText: 'rating'),
                    // set the categories to choose from
                    // convert string list to DropDownMenuItem list
                    items: ratings
                        .map((rating) => DropdownMenuItem(
                              value: rating,
                              child: Text(rating.toString()),
                            ))
                        .toList(),
                    onChanged: (rating) {
                      // Do something with the selected category
                    },
                  ),

                  // 6th field: description review (optional)
                  FormBuilderTextField(
                    name: 'description',
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                  ),

                  // separtion between fields
                  SizedBox(height: 28.0),

                  // submit button
                  ElevatedButton(
                    onPressed: () {
                      if (_fbKey.currentState!.saveAndValidate()) {
                        // submit the form data
                        _submitReview(
                            widget.serviceCallId, _fbKey.currentState!.value);
                      }
                    },
                    child: Text('Submit Review'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitReview(
      String serviceCallId, Map<String, dynamic> formData) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      // Save review rating and review desc to Firestore review_calls
      try {
        CollectionReference service_calls =
            FirebaseFirestore.instance.collection('service_calls');

        Map<String, dynamic> updatedData = {
          'rating': formData['rating'],
          'reviewDesc': formData['description'],
          // Add other fields you want to update
        };

        // Update the document with the specified userId
        await service_calls.doc(serviceCallId).update(updatedData);

        print('User data updated successfully!');
      } catch (error) {
        print('Error updating user data: $error');
      }
    }
  }
}
