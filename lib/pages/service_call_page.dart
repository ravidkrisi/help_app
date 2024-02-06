import 'package:flutter/material.dart';
import 'package:help_app/objects/service_call.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/pages/home_page_client.dart'; // Import HomePageCustomer page

class ServiceCallPage extends StatefulWidget {
  const ServiceCallPage({super.key});

  @override
  State<ServiceCallPage> createState() => _ServiceCallPageState();
}

class _ServiceCallPageState extends State<ServiceCallPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  static void _submitForm(Map<String, dynamic> formData) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    AppUser? customer = await AppUser.getUserById(userId!);

    ServiceCall.addServiceCallDataToFirestore(ServiceCall(
      serviceCallId: null,
      customer: customer,
      provider: null,
      category: formData['category'],
      area: formData['area'],
      description: formData['description'],
      cost: formData['cost'],
      isCompleted: false,
      rating: null,
      reviewDesc: null,
    ));
  }

  List<String> categories = ['plumbering', 'more'];
  List<String> regions = ['south', 'north', 'east', 'west'];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormBuilderDropdown(
                      name: 'category',
                      decoration:
                          const InputDecoration(labelText: 'Category *'),
                      items: categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (category) {},
                    ),
                    const SizedBox(height: 16.0),
                    FormBuilderDropdown(
                      name: 'area',
                      decoration: const InputDecoration(labelText: 'Area *'),
                      items: regions
                          .map((region) => DropdownMenuItem(
                                value: region,
                                child: Text(region),
                              ))
                          .toList(),
                      onChanged: (region) {},
                    ),
                    const SizedBox(height: 16.0),
                    FormBuilderTextField(
                      name: 'description',
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    FormBuilderTextField(
                      name: 'cost',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Cost'),
                    ),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          _submitForm(_formKey.currentState!.value);
                          // Navigate back to HomePageCustomer after submitting the form
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageCustomer(),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(120, 50),
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(fontSize: 16),
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
