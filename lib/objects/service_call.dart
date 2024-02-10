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
  bool? isReviewed;

  ServiceCall({
    required this.serviceCallId,
    required this.customer,
    required this.provider,
    required this.category,
    required this.area,
    required this.description,
    required this.cost,
    required this.isCompleted,
    required this.isReviewed,
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
      'isCompleted': call.isCompleted,
      'isReviewed': call.isReviewed,
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
        AppUser? provider = await AppUser.getUserById(data['providerID']);

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
          isReviewed: data['isReviewed'] ?? false,
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

  // update the review info of service call
  Future<void> setIsReviewed(bool isReviewed) async {
    try {
      // create reference to service_calls collection
      CollectionReference service_calls =
          FirebaseFirestore.instance.collection('service_calls');

      // data to be updated
      Map<String, dynamic> updatedData = {
        'isReviewed': isReviewed,
      };
      print(serviceCallId);
      // Update the document with the specified userId
      await service_calls.doc(serviceCallId).update(updatedData);

      print('call is reviewd updated successfully!');
    } catch (error) {
      print('Error updating user data: $error');
    }
  }

  // Function to retrieve all posts and create a list of Post instances
  static Future<List<ServiceCall?>> getAllPosts() async {
    QuerySnapshot callsSnapshot =
        await FirebaseFirestore.instance.collection('service_calls').get();

    List<Future<ServiceCall?>> callsFutures = [];

    for (QueryDocumentSnapshot callDocument in callsSnapshot.docs) {
      String callId = callDocument.id;
      // You can add more properties as needed
      Future<ServiceCall?> call = ServiceCall.getServiceCallById(callId);
      callsFutures.add(call);
    }

    // wait for all the futures to complete and then filter out null values
    List<ServiceCall?> calls = [];
    for (var future in callsFutures) {
      var call = await future;
      calls.add(call);
    }

    return calls;
  }

  // Function to retrieve all posts and create a list of Post instances
  static Future<List<ServiceCall?>> getAllCustomerPosts(
      String customerID) async {
    QuerySnapshot callsSnapshot = await FirebaseFirestore.instance
        .collection('service_calls')
        .where('customerID', isEqualTo: customerID)
        .get();

    List<Future<ServiceCall?>> callsFutures = [];

    for (QueryDocumentSnapshot callDocument in callsSnapshot.docs) {
      String callId = callDocument.id;
      // You can add more properties as needed
      Future<ServiceCall?> call = ServiceCall.getServiceCallById(callId);
      callsFutures.add(call);
    }

    // wait for all the futures to complete and then filter out null values
    List<ServiceCall?> calls = [];
    for (var future in callsFutures) {
      var call = await future;
      calls.add(call);
    }

    return calls;
  }
}
