import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/components/custom_scaffold.dart';
import 'package:help_app/view_model/service_call_view_model.dart';
import 'package:provider/provider.dart';

class CreateServiceCallPage extends StatelessWidget {
  const CreateServiceCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Service Calls'),
      ),
      body: Center(
        // Use the Consumer widget to listen to changes in CounterModel
        child: Consumer<ServiceCallViewModel>(
          builder: (context, serviceCallViewModel, child) {
            return CustomScaffold(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: FormBuilder(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      // height: screenHeight * 2 / 3,
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 10.0),
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
                            // category field
                            FormBuilderDropdown<TaskCategory>(
                              onChanged: (value) =>
                                  serviceCallViewModel.category = value,
                              name: 'category',
                              decoration:
                                  const InputDecoration(labelText: 'Category*'),
                              items: TaskCategory.values
                                  .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(enumToString(value))))
                                  .toList(),
                            ),

                            // divider
                            const SizedBox(height: 16.0),

                            // city field
                            FormBuilderDropdown<City>(
                              onChanged: (value) => serviceCallViewModel.city = value,
                              name: 'city',
                              decoration:
                                  const InputDecoration(labelText: 'City*'),
                              items: City.values
                                  .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(enumToString(value))))
                                  .toList(),
                            ),

                            // divider
                            const SizedBox(height: 16.0),

                            // description field
                            FormBuilderTextField(
                              onChanged: (value) => serviceCallViewModel.desc = value,
                              name: 'description',
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                              ),
                            ),

                            //
                            const SizedBox(height: 16.0),
                            FormBuilderTextField(
                              onChanged: (value) => serviceCallViewModel.cost = value,
                              name: 'cost',
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Cost*'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ]),
                            ),
                            const SizedBox(height: 40.0),
                            ElevatedButton(
                              onPressed: () async {
                                serviceCallViewModel.submitForm(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
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
          },
        ),
      ),
    ));
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:help_app/model/user.dart';
// import 'package:help_app/utils/enums.dart';
// import 'package:help_app/view/components/custom_scaffold.dart';
// import 'package:help_app/view_model/service_call_view_model.dart';
// import 'package:provider/provider.dart';

// class CreateServiceCallPage extends StatefulWidget {

//   const CreateServiceCallPage({required this.user});

//   @override
//   _CreateServiceCallPageState createState() => _CreateServiceCallPageState();
// }

// class _CreateServiceCallPageState extends State<CreateServiceCallPage> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Service Calls'),
//         ),
//         body: Center(
//           child: Consumer<ServiceCallViewModel>(
//             builder: (context, serviceCallVM, child) {
//               return CustomScaffold(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: SingleChildScrollView(
//                     child: FormBuilder(
//                       key: _formKey,
//                       autovalidateMode: AutovalidateMode.always,
//                       child: Column(
//                         children: [
//                           // category field
//                           FormBuilderDropdown<TaskCategory>(
//                             onChanged: (value) =>
//                                 serviceCallVM.category = value,
//                             name: 'category',
//                             decoration:
//                                 const InputDecoration(labelText: 'Category*'),
//                             items: TaskCategory.values
//                                 .map((value) => DropdownMenuItem(
//                                     value: value,
//                                     child: Text(enumToString(value))))
//                                 .toList(),
//                           ),

//                           // divider
//                           const SizedBox(height: 16.0),

//                           // city field
//                           FormBuilderDropdown<City>(
//                             onChanged: (value) => serviceCallVM.city = value,
//                             name: 'city',
//                             decoration:
//                                 const InputDecoration(labelText: 'City*'),
//                             items: City.values
//                                 .map((value) => DropdownMenuItem(
//                                     value: value,
//                                     child: Text(enumToString(value))))
//                                 .toList(),
//                           ),

//                           // divider
//                           const SizedBox(height: 16.0),

//                           // description field
//                           FormBuilderTextField(
//                             onChanged: (value) => serviceCallVM.desc = value,
//                             name: 'description',
//                             maxLines: 3,
//                             decoration: const InputDecoration(
//                               labelText: 'Description',
//                               alignLabelWithHint: true,
//                               border: OutlineInputBorder(),
//                             ),
//                           ),

//                           //
//                           const SizedBox(height: 16.0),
//                           FormBuilderTextField(
//                             name: 'cost',
//                             keyboardType: TextInputType.number,
//                             decoration:
//                                 const InputDecoration(labelText: 'Cost*'),
//                             validator: FormBuilderValidators.compose([
//                               FormBuilderValidators.required(),
//                               FormBuilderValidators.numeric(),
//                             ]),
//                           ),
//                           const SizedBox(height: 40.0),
//                           ElevatedButton(
//                             onPressed: () async {
//                               serviceCallVM.addServiceCall();
//                             },
//                             style: ButtonStyle(
//                               backgroundColor:
//                                   MaterialStateProperty.all<Color>(Colors.blue),
//                               foregroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.white),
//                               fixedSize: MaterialStateProperty.all<Size>(
//                                 const Size(120, 50),
//                               ),
//                               textStyle: MaterialStateProperty.all<TextStyle>(
//                                 const TextStyle(fontSize: 16),
//                               ),
//                             ),
//                             child: const Text('Submit'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
