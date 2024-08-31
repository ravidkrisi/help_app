// // navigation_provider.dart

// import 'package:flutter/material.dart';
// import 'package:help_app/utils/routes/routes.dart';

// class NavigationProvider extends ChangeNotifier {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   String currentRoute = RouteNames.splash; // Initial route

//   void goTo(String routeName) {
//     currentRoute = routeName;
//     notifyListeners();
//   }
// }