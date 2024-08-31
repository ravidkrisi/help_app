import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/model/user.dart'; // Import your User model
import 'dart:async';

import 'package:help_app/utils/result.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // // Get user by ID
  // Stream<Result<AppUser>> getUserById(String userId) {
  //   try {
  //     return _firestore
  //         .collection('users')
  //         .where('uid', isEqualTo: userId)
  //         .snapshots()
  //         .map<Result<AppUser>>((querySnapshot) {
  //       if (querySnapshot.docs.isNotEmpty) {
  //         // Since there should be only one document with the given userId,
  //         // we assume the first document in the query snapshot is the one we want
  //         final userData = querySnapshot.docs.first.data();
  //         return Result.success(
  //             AppUser.fromJson(userData as Map<String, dynamic>));
  //       } else {
  //         return Result.failure(Exception("User with ID $userId not found"));
  //       }
  //     }).handleError((error) {
  //       return Result.failure(error);
  //     });
  //   } catch (e) {
  //     return Stream.value(Result.failure(e as Exception));
  //   }
  // }

  Stream<Result<AppUser>> getUserById(String userId) {
    try {
      return _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1) // Limit the query to only retrieve the first document
          .snapshots()
          .map<Result<AppUser>>((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          // Assuming there's only one document, retrieve it
          final userData = querySnapshot.docs.first.data();
          return Result.success(
              AppUser.fromJson(userData as Map<String, dynamic>));
        } else {
          return Result.failure(Exception("User with ID $userId not found"));
        }
      }).handleError((error) {
        return Result.failure(error);
      });
    } catch (e) {
      return Stream.value(Result.failure(e as Exception));
    }
  }

  Future<Result<AppUser>> getUserById2(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Since there should be only one document with the given userId,
        // we assume the first document in the query snapshot is the one we want
        final userData = querySnapshot.docs.first.data();
        return Result.success(
            AppUser.fromJson(userData as Map<String, dynamic>));
      } else {
        return Result.failure(Exception("User with ID $userId not found"));
      }
    } catch (e) {
      return Result.failure(e as Exception);
    }
  }

  // add user the db
  Future<Result<AppUser>> addUserToFirestore(AppUser user) async {
    try {
      // convert user to json
      Map<String, dynamic> data = user.toJson();
      await _firestore.collection('users').add(data);
      return Result.success(user);
    } on FirebaseException catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> setRating(String userId, num rating) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocId = userDocSnapshot.docs.first.id;
        await _firestore.collection('users').doc(userDocId).update({
          'rating': rating,
        });
      } else {
        throw Exception("User with ID $userId not found");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> setTotalEarning(String userId, num totalEarning) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocId = userDocSnapshot.docs.first.id;
        await _firestore.collection('users').doc(userDocId).update({
          'totalEarning': totalEarning,
        });
      } else {
        throw Exception("User with ID $userId not found");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> setCallsCount(String userId, num callsCount) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocId = userDocSnapshot.docs.first.id;
        await _firestore.collection('users').doc(userDocId).update({
          'callsCount': callsCount,
        });
      } else {
        throw Exception("User with ID $userId not found");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> newData) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocId = userDocSnapshot.docs.first.id;
        await _firestore.collection('users').doc(userDocId).update(newData);
      } else {
        throw Exception("User with ID $userId not found");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<num> getRating(String userId) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocData = userDocSnapshot.docs.first.data();
        // Check if the 'rating' field exists and return its value
        if (userDocData['rating'] == null) {
          return 0;
        }
        return userDocData['rating'] as num;
      }
    } catch (e) {
      // Handle any errors that might occur
      throw e;
    }
    throw Exception("get rating error");
  }

  Future<num> getTotalEarning(String userId) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocData = userDocSnapshot.docs.first.data();
        // Check if the 'rating' field exists and return its value
        if (userDocData['totalEarning'] == null) {
          return 0;
        }
        return userDocData['totalEarning'] as num;
      }
    } catch (e) {
      // Handle any errors that might occur
      throw e;
    }
    throw Exception("get totalEarning error");
  }

  Future<num> getCallsCount(String userId) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocData = userDocSnapshot.docs.first.data();
        // Check if the 'rating' field exists and return its value
        if (userDocData['callsCount'] == null) {
          return 0;
        }
        return userDocData['callsCount'] as num;
      }
    } catch (e) {
      // Handle any errors that might occur
      throw e;
    }
    throw Exception("get callsCount error");
  }

  Future<num> getReviewsCount(String userId) async {
    try {
      final userDocSnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocData = userDocSnapshot.docs.first.data();
        // Check if the 'rating' field exists and return its value
        if (userDocData['reviewsCount'] == null) {
          return 0;
        }
        return userDocData['reviewsCount'] as num;
      }
    } catch (e) {
      // Handle any errors that might occur
      throw e;
    }
    throw Exception("get callsCount error");
  }
}
