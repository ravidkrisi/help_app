import 'package:flutter/material.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCallPage extends StatefulWidget {
  const ServiceCallPage({super.key});

  // set unique value to the form

  @override
  State<ServiceCallPage> createState() => _ServiceCallPageState();
}

class _ServiceCallPageState extends State<ServiceCallPage> {
  // set unique value to the form
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // add form data the service_calls firestore collection
  void _submitForm(Map<String, dynamic> formData) {
    // get user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Form is valid, save data to Firestore
    FirebaseFirestore.instance.collection('service_calls').add({
      'userId': userId,
      'category': formData['category'],
      'area': formData['area'],
      'description': formData['description'],
      'cost': formData['cost'],
      'isCompleted': false,
    }).then((value) {
      // Document added successfully
      print('Data stored in Firestore!');
    }).catchError((error) {
      // Handle errors
      print('Error storing data in Firestore: $error');
    });
  }

  // variables
  // categories list
  List<String> categories = ['plumbering', 'more'];
  List<String> regions = ['south', 'north', 'east', 'west'];

  @override
  Widget build(BuildContext context) {
    // set variable to get the size of screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // // firestore connection
    // // get user ID string
    // String userId = FirebaseAuth.instance.currentUser!.uid;
    // // reference for service_calls collection
    // CollectionReference service_calls =
    //     FirebaseFirestore.instance.collection("service_calls");

    // use the custom scaffold for all screens
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        // enable scroll if keyboard is on screen
        child: SingleChildScrollView(
          // create the form for service call
          child: FormBuilder(
            // give the unique key to each form
            key: _formKey,
            // control when the form fields should be automatically validated
            autovalidateMode: AutovalidateMode.always,
            child: Container(
              // decoration for the form box
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

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // set column to the vetical and horizontal center
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1st field: category
                    // this field is a drop down for the customer to choose from
                    FormBuilderDropdown(
                      name: 'category',
                      // set decoration
                      decoration:
                          const InputDecoration(labelText: 'Category *'),
                      // set the categories to choose from
                      // convert string list to DropDownMenuItem list
                      items: categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (category) {
                        // Do something with the selected category
                      },
                    ),

                    // sepration between fields
                    const SizedBox(height: 16.0),

                    // 2nd field: area
                    FormBuilderDropdown(
                      name: 'area',
                      // set decoration
                      decoration: const InputDecoration(labelText: 'Area *'),
                      // set the categories to choose from
                      // convert string list to DropDownMenuItem list
                      items: regions
                          .map((region) => DropdownMenuItem(
                                value: region,
                                child: Text(region),
                              ))
                          .toList(),
                      onChanged: (region) {
                        // Do something with the selected category
                      },
                    ),

                    // separtion between fields
                    const SizedBox(height: 16.0),

                    // 3rd field: description of the service call
                    FormBuilderTextField(
                      name: 'description',
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    // sepration between fields
                    const SizedBox(height: 16.0),

                    // 4th field: Cost (numeric only)
                    FormBuilderTextField(
                      name: 'cost',
                      // set keyboard to number only decoration
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Cost'),
                    ),
                    // separtion between fields
                    const SizedBox(height: 40.0),
                    // submit button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          // submit the form data
                          _submitForm(_formKey.currentState!.value);
                        }
                      },
                      // decoration for the button
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set button background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Set font color
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(120, 50), // Set width and height
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(fontSize: 16), // Set font size
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
