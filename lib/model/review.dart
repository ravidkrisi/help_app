import 'package:help_app/model/service_call.dart';
import 'package:help_app/model/user.dart';

class Review {
  AppUser customer;
  AppUser provider;
  ServiceCall call;
  num rating = -1;
  String desc = '';

  Review(
      {required this.customer,
      required this.provider,
      required this.call,
      required this.rating,
      required this.desc});
}
