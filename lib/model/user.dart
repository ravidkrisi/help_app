// Abstract Model
import 'package:help_app/utils/enums.dart';

abstract class AppUser {
  final String uid;
  final String email;
  final String name;
  final UserType type;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.type,
  });

  // factory method to create our users
  factory AppUser.fromJson(Map<String, dynamic> json) {
    // case 1: customer user
    if (json['userType'] == UserType.customer ||
        json['userType'] == 'customer') {
      return CustomerUser.fromJson(json);
    }
    // case 2: provider user
    else if (json['userType'] == UserType.provider ||
        json['userType'] == 'provider') {
      return ProviderUser.fromJson(json);
    }
    // case 3: invalid UserType
    else {
      throw Exception('Invalid userType');
    }
  }

  // create json out of user instance
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'userType': enumToString(type),
    };
  }
}

// Model: Customer
class CustomerUser extends AppUser {
  CustomerUser(
      {required String uid,
      required String email,
      required String name,
      required UserType type})
      : super(uid: uid, email: email, name: name, type: type);

  // create customer instance
  factory CustomerUser.fromJson(Map<String, dynamic> json) {
    return CustomerUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      type: UserType.customer,
    );
  }

  // create json out of customer instance
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'userType': enumToString(type),
    };
  }
}

// Model: Provider
class ProviderUser extends AppUser {
  num? rating;
  num? totalEarning;
  num? callsCount;
  num? reviewsCount;

  // constructor
  ProviderUser({
    required String uid,
    required String email,
    required String name,
    required UserType type,
    this.rating,
    this.callsCount,
    this.totalEarning,
    this.reviewsCount,
  }) : super(uid: uid, email: email, name: name, type: type);

  // factory function
  factory ProviderUser.fromJson(Map<String, dynamic> json) {
    return ProviderUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      type: UserType.provider,
      rating: json['rating'],
      totalEarning: json['totalEarning'],
      callsCount: json['callsCount'],
      reviewsCount: json['reviewsCount'],
    );
  }

  // create json out of provider instance
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'userType': enumToString(type),
      'rating': rating,
      'callsCount': callsCount,
      'totalEarning': totalEarning,
      'reviewsCount': reviewsCount
    };
  }
}
