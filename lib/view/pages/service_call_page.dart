// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:help_app/view_model/service_call_feed_view_model.dart';
// import 'package:help_app/model/service_call.dart';

// class ServiceCallListView extends StatelessWidget {
//   final String? customerId;
//   final String? providerId;
//   final TextEditingController _idController = TextEditingController();

//   ServiceCallListView({Key? key, this.customerId, this.providerId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Service Calls'),
//       ),
//       body: _buildForm(context),
//     );
//   }

//   Widget _buildServiceCallList(BuildContext context) {
//     return Consumer<ServiceCallFeedViewModel>(
//       builder: (context, viewModel, child) {
//         Stream<List<ServiceCall>> stream;
//         if (customerId != null) {
//           viewModel.fetchServiceCallsByCustomer(customerId!);
//           stream = viewModel.customerServiceCallsStream;
//         } else if (providerId != null) {
//           viewModel.fetchServiceCallsByProvider(providerId!);
//           stream = viewModel.providerServiceCallsStream;
//         } else {
//           stream = viewModel.allServiceCallsStream;
//         }

//         return StreamBuilder<List<ServiceCall>>(
//           stream: stream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final serviceCalls = snapshot.data!;
//               return ListView.builder(
//                 itemCount: serviceCalls.length,
//                 itemBuilder: (context, index) {
//                   final serviceCall = serviceCalls[index];
//                   return ListTile(
//                     title: Text(serviceCall.callId),
//                     // subtitle: Text('Cost: \$${serviceCall.cost.toString()}'),
//                     // trailing: serviceCall.isCompleted ? Icon(Icons.check) : null,
//                   );
//                 },
//               );
//             }
//           },
//         );
//       },
//     );
//   }

//   Widget _buildForm(BuildContext context) {
//     return Consumer<ServiceCallFeedViewModel>(
//       builder: (context, viewModel, child) {
//         Stream<List<ServiceCall>> stream;
//         if (customerId != null) {
//           viewModel.fetchServiceCallsByCustomer(customerId!);
//           stream = viewModel.customerServiceCallsStream;
//         } else if (providerId != null) {
//           viewModel.fetchServiceCallsByProvider(providerId!);
//           stream = viewModel.providerServiceCallsStream;
//         } else {
//           stream = viewModel.allServiceCallsStream;
//         }

//         return StreamBuilder<List<ServiceCall>>(
//           stream: stream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: _idController,
//                     decoration: InputDecoration(
//                       labelText: 'Service Call ID',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       viewModel.addServiceCall(_idController.text);
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }
