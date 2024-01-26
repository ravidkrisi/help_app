import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/objects/user.dart';

class ServiceCall {
  String? serviceCallId;
  AppUser? customer;
  AppUser? provider;
  String? category;
  String? area;
  String? description;
  String? cost;
  bool? isCompleted;
  int? rating;
  String? reviewDesc;

  ServiceCall({
    required this.serviceCallId,
    required this.customer,
    required this.provider,
    required this.category,
    required this.area,
    required this.description,
    required this.cost,
    required this.isCompleted,
    required this.rating,
    required this.reviewDesc,
  });

  // Function to add user data to Firestore
  static Future<void> addServiceCallDataToFirestore(ServiceCall call) async {
    CollectionReference service_calls =
        FirebaseFirestore.instance.collection('service_calls');

    await service_calls.add({
      'customerID': call.customer?.userId,
      'providerID': call.provider?.userId,
      'category': call.category,
      'area': call.area,
      'description': call.description,
      'cost': call.cost,
      'isCompleted': false,
      'rating': null,
      'reviewDesc': null,
    }).then((value) {
      // Document added successfully
      print('Data stored in Firestore!');
    }).catchError((error) {
      // Handle errors
      print('Error storing data in Firestore: $error');
    });
  }

  // Function to retrieve service call information from Firestore by ID
  static Future<ServiceCall?> getServiceCallById(String serviceCallId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('service_calls')
          .doc(serviceCallId)
          .get();

      if (documentSnapshot.exists) {
        // Extract data from the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // validate provider and customer variables
        AppUser? customer = await AppUser.getUserById(data['customerID']);
        AppUser? provider = await AppUser.getUserById(data['customerID']);

        // Create a ServiceCall object
        ServiceCall serviceCall = ServiceCall(
          serviceCallId: serviceCallId,
          customer: customer,
          provider: provider,
          category: data['category'] ?? '',
          area: data['area'] ?? '',
          description: data['description'] ?? '',
          cost: data['cost'] ?? '',
          isCompleted: data['isCompleted'] ?? false,
          rating: data['rating'] ?? 0,
          reviewDesc: data['reviewDesc'] ?? '',
        );

        return serviceCall;
      } else {
        // Document does not exist
        print("doc does not exist");
        return null;
      }
    } catch (error) {
      // Handle errors
      print('Error retrieving service call: $error');
      return null;
    }
  }
}
