import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_app/model/service_call.dart';
import 'package:help_app/model/user.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/utils/enums.dart';

class ServiceCallService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();

  Stream<List<ServiceCall>> getAllOpenServiceCallsStream() {
    return _firestore
        .collection('service_calls')
        .where('isCompleted', isEqualTo: false)
        .where('inProgress', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ServiceCall> serviceCalls = [];

      await Future.forEach(snapshot.docs, (doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final customerId = data['customerId'];
        final providerId = data['providerId'];

        // get customer and provider concurrently
        final customerFuture = _userService.getUserById2(customerId);
        final providerFuture = _userService.getUserById2(providerId);

        final customer = await customerFuture;
        final provider = await providerFuture;

        // Modify data with appUser for customer and provider fields
        data['customerId'] = customer.value;
        data['providerId'] = provider.value;

        serviceCalls.add(ServiceCall.fromJson(data));
      });

      return serviceCalls;
    });
  }

  // Get service calls for a specific customer
  Stream<List<ServiceCall>> getOpenServiceCallsByCustomerStream(
      String customerId) {
    return _firestore
        .collection('service_calls')
        .where('customerId', isEqualTo: customerId)
        .where('inProgress', isEqualTo: false)
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ServiceCall> serviceCalls = [];

      await Future.forEach(snapshot.docs, (doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final customerId = data['customerId'];
        final providerId = data['providerId'];

        // get customer and provider concurrently
        final customerFuture = _userService.getUserById2(customerId);
        final providerFuture = _userService.getUserById2(providerId);

        final customer = await customerFuture;
        final provider = await providerFuture;

        // Modify data with appUser for customer and provider fields
        data['customerId'] = customer.value;
        data['providerId'] = provider.value;

        serviceCalls.add(ServiceCall.fromJson(data));
      });

      return serviceCalls;
    });
  }

  // Get service calls for a specific customer- in progress
  Stream<List<ServiceCall>> getCompletedServiceCallsByCustomerStream(
      String customerId) {
    return _firestore
        .collection('service_calls')
        .where('customerId', isEqualTo: customerId)
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ServiceCall> serviceCalls = [];

      await Future.forEach(snapshot.docs, (doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final customerId = data['customerId'];
        final providerId = data['providerId'];

        // get customer and provider concurrently
        final customerFuture = _userService.getUserById2(customerId);
        final providerFuture = _userService.getUserById2(providerId);

        final customer = await customerFuture;
        final provider = await providerFuture;

        // Modify data with appUser for customer and provider fields
        data['customerId'] = customer.value;
        data['providerId'] = provider.value;

        serviceCalls.add(ServiceCall.fromJson(data));
      });

      return serviceCalls;
    });
  }

  // Get service calls for a specific customer- in progress
  Stream<List<ServiceCall>> getCompletedServiceCallsByProviderStream(
      String providerId) {
    return _firestore
        .collection('service_calls')
        .where('providerId', isEqualTo: providerId)
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ServiceCall> serviceCalls = [];

      await Future.forEach(snapshot.docs, (doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final customerId = data['customerId'];
        final providerId = data['providerId'];

        // get customer and provider concurrently
        final customerFuture = _userService.getUserById2(customerId);
        final providerFuture = _userService.getUserById2(providerId);

        final customer = await customerFuture;
        final provider = await providerFuture;

        // Modify data with appUser for customer and provider fields
        data['customerId'] = customer.value;
        data['providerId'] = provider.value;

        serviceCalls.add(ServiceCall.fromJson(data));
      });

      return serviceCalls;
    });
  }

  // Get service calls for a specific customer
  Stream<List<ServiceCall>> getInProgressServiceCallsByProviderStream(
      String providerId) {
    return _firestore
        .collection('service_calls')
        .where('providerId', isEqualTo: providerId)
        .where('inProgress', isEqualTo: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ServiceCall> serviceCalls = [];

      await Future.forEach(snapshot.docs, (doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final customerId = data['customerId'];
        final providerId = data['providerId'];

        // get customer and provider concurrently
        final customerFuture = _userService.getUserById2(customerId);
        final providerFuture = _userService.getUserById2(providerId);

        final customer = await customerFuture;
        final provider = await providerFuture;

        // Modify data with appUser for customer and provider fields
        data['customerId'] = customer.value;
        data['providerId'] = provider.value;

        serviceCalls.add(ServiceCall.fromJson(data));
      });

      return serviceCalls;
    });
  }

  // Get service calls for a specific customer
  Stream<List<ServiceCall>> getInProgressServiceCallsByCustomerStream(
      String customerId) {
    return _firestore
        .collection('service_calls')
        .where('customerId', isEqualTo: customerId)
        .where('inProgress', isEqualTo: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ServiceCall> serviceCalls = [];

      await Future.forEach(snapshot.docs, (doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final customerId = data['customerId'];
        final providerId = data['providerId'];

        // get customer and provider concurrently
        final customerFuture = _userService.getUserById2(customerId);
        final providerFuture = _userService.getUserById2(providerId);

        final customer = await customerFuture;
        final provider = await providerFuture;

        // Modify data with appUser for customer and provider fields
        data['customerId'] = customer.value;
        data['providerId'] = provider.value;

        serviceCalls.add(ServiceCall.fromJson(data));
      });

      return serviceCalls;
    });
  }

//   // Get service calls for a specific provider and calculate average rating
//   Stream<List<ServiceCall>> getInProgressServiceCallsByProviderStream(
//       String providerId) {
//     return _firestore
//         .collection('service_calls')
//         .where('providerId', isEqualTo: providerId)
//         .where('isInProgress', isEqualTo: true)
//         .snapshots()
//         .asyncMap((snapshot) async {
//       final List<ServiceCall> serviceCalls = [];

//       num totalRating = 0; // Total rating of all calls
//       num ratedCallCount = 0; // Total number of rated calls
//       num callsCount = 0; // Total number of rated calls
//       num totalEarning = 0; // total earnings from all calls

//       await Future.forEach(snapshot.docs, (doc) async {
//         final data = doc.data() as Map<String, dynamic>;
//         final customerId = data['customerId'];
//         final providerId = data['providerId'];

//         // get customer and provider concurrently
//         final customerFuture = _userService.getUserById2(customerId);
//         final providerFuture = _userService.getUserById2(providerId);

//         final customer = await customerFuture;
//         final provider = await providerFuture;

//         // Modify data with appUser for customer and provider fields
//         data['customerId'] = customer.value;
//         data['providerId'] = provider.value;

//         serviceCalls.add(ServiceCall.fromJson(data));

//         // Calculate average rating
//         if (data.containsKey('rating')) {
//           if (data['rating'] != null) {
//             totalRating += data['rating'];
//             ratedCallCount++;
//           }
//         }

//         callsCount++;
//         totalEarning += data['cost'];
//       });

//       double averageRating =
//           ratedCallCount > 0 ? totalRating / ratedCallCount : 0;

//       // Set provider rating
//       await _userService.setRating(providerId, averageRating);
//       await _userService.setCallsCount(providerId, callsCount);
//       await _userService.setTotalEarning(providerId, totalEarning);

//       return serviceCalls;
//     });
//   }

//   // Get service calls for a specific provider and calculate average rating
//   Stream<List<ServiceCall>> getCompletedServiceCallsByProviderStream(
//       String providerId) {
//     return _firestore
//         .collection('service_calls')
//         .where('providerId', isEqualTo: providerId)
//         .where('isCompleted', isEqualTo: true)
//         .snapshots()
//         .asyncMap((snapshot) async {
//       final List<ServiceCall> serviceCalls = [];

//       num totalRating = 0; // Total rating of all calls
//       num ratedCallCount = 0; // Total number of rated calls
//       num callsCount = 0; // Total number of rated calls
//       num totalEarning = 0; // total earnings from all calls

//       await Future.forEach(snapshot.docs, (doc) async {
//         final data = doc.data() as Map<String, dynamic>;
//         final customerId = data['customerId'];
//         final providerId = data['providerId'];

//         // get customer and provider concurrently
//         final customerFuture = _userService.getUserById2(customerId);
//         final providerFuture = _userService.getUserById2(providerId);

//         final customer = await customerFuture;
//         final provider = await providerFuture;

//         // Modify data with appUser for customer and provider fields
//         data['customerId'] = customer.value;
//         data['providerId'] = provider.value;

//         serviceCalls.add(ServiceCall.fromJson(data));

//         // Calculate average rating
//         if (data.containsKey('rating')) {
//           if (data['rating'] != null) {
//             totalRating += data['rating'];
//             ratedCallCount++;
//           }
//         }

//         callsCount++;
//         totalEarning += data['cost'];
//       });

//       double averageRating =
//           ratedCallCount > 0 ? totalRating / ratedCallCount : 0;

//       // Set provider rating
//       await _userService.setRating(providerId, averageRating);
//       await _userService.setCallsCount(providerId, callsCount);
//       await _userService.setTotalEarning(providerId, totalEarning);

//       return serviceCalls;
//     });
//   }

  // Add a service call
  Future<void> addServiceCall(
    AppUser customer,
    TaskCategory category,
    City city,
    String desc,
    num cost,
  ) async {
    try {
      Map<String, dynamic> data = {
        'callId': '',
        'customerId': customer.uid,
        'providerId': '',
        'category': enumToString(category),
        'city': enumToString(city),
        'desc': desc,
        'cost': cost,
        'inProgress': false,
        'isCompleted': false,
        'isReviewed': false,
        'rating': null,
      };
      DocumentReference documentReference =
          await _firestore.collection('service_calls').add(data);

      // Get the ID of the newly added document
      String docId = documentReference.id;

      // Update the 'callId' field of the added document with the generated document ID
      await documentReference.update({'callId': docId});

      print("added call to db");
    } catch (e) {
      print('Error adding service call: $e');
      // Handle error appropriately, like showing a snackbar or logging
    }
  }

  Future<void> updateCall(String callId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('service_calls').doc(callId).update(newData);
      print('Service call with ID $callId updated successfully');
    } catch (e) {
      print('Error updating service call with ID $callId: $e');
      throw e;
    }
  }


  // Update the providerId field in a service call document
  Future<void> updateProviderId(String serviceCallId, String providerId) async {
    try {
      await _firestore.collection('service_calls').doc(serviceCallId).update({
        'providerId': providerId,
        'inProgress': true,
      });
      print(
          'Provider ID updated successfully for service call: $serviceCallId');
    } catch (e) {
      print('Error updating provider ID for service call $serviceCallId: $e');
      throw e; // Rethrow the exception for handling at the caller level if needed
    }
  }

  Future<void> setIsReviewed(String callId, bool isReviewed) async {
    try {
      await _firestore.collection('service_calls').doc(callId).update({
        'isReviewed': isReviewed,
      });
      print('isReviewed field updated successfully for call ID: $callId');
    } catch (e) {
      print('Error updating isReviewed field for call ID $callId: $e');
      throw e; // Rethrow the exception for handling at the caller level if needed
    }
  }

  Future<void> setRating(String callId, num rating) async {
    try {
      await _firestore.collection('service_calls').doc(callId).update({
        'rating': rating,
      });
      print('isReviewed field updated successfully for call ID: $callId');
    } catch (e) {
      print('Error updating isReviewed field for call ID $callId: $e');
      throw e; // Rethrow the exception for handling at the caller level if needed
    }
  }
}

