import 'package:help_app/model/user.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/utils/result.dart';

class ServiceCall {
  String callId;
  AppUser customer;
  AppUser? provider;
  TaskCategory category;
  City city;
  String desc;
  num cost;
  bool inProgress;
  bool isCompleted;
  bool isReviewed;
  num? rating;

  ServiceCall({
    required this.callId,
    required this.customer,
    this.provider,
    required this.category,
    required this.city,
    required this.desc,
    required this.cost,
    this.inProgress = false,
    this.isCompleted = false,
    this.isReviewed = false,
    this.rating,
  });

  // create serviceCall instance from json
  factory ServiceCall.fromJson(Map<String, dynamic> json){
    return ServiceCall(
      callId: json['callId'],
      customer:  json['customerId'],
      provider: json['providerId'],
      category: TaskCategory.values
          .firstWhere((category) => enumToString(category) == json['category']),
      city:
          City.values.firstWhere((city) => enumToString(city) == json['city']),
      desc: json['desc'],
      cost: json['cost'],
      inProgress: json['inProgress'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      isReviewed: json['isReviewed'] ?? false,
      rating: json['rating'] ?? 0,
    );
  }

  // Convert ServiceCall object to a map
  Map<String, dynamic> toJson() {
    return {
      'callId': callId,
      // Add more properties as needed
    };
  }
}
