// import 'package:flutter/material.dart';
// import 'package:help_app/view/pages/create_service_call_page.dart';
// import 'package:help_app/view/pages/home_page.dart';
// import 'package:help_app/view/pages/sign_in_page.dart';
// import 'package:help_app/view/pages/sign_up_page.dart';
// import 'package:help_app/view/pages/splash_page.dart';
// import 'package:help_app/view/pages/welcome_page.dart';

// class RouteNames {
//   static const String splash = "splash_page";
//   static const String welcome = "welcome_page";
//   static const String signIn = "login_page";
//   static const String home = "home_page";
//   static const String signUp = "sign_up_page";
//   static const String createServiceCall = "create_service_call_page";
// }

// class Routes {
//   static Route<dynamic> generateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case (RouteNames.home):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const HomePage());
//       case (RouteNames.signIn):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SignInPage());
//       case (RouteNames.signUp):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SignUpPage());
//       case (RouteNames.splash):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SplashPage());
//       case (RouteNames.welcome):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const WelcomePage());
//       // case (RouteNames.createServiceCall):
//       //   return MaterialPageRoute(
//       //       builder: (BuildContext context) => const CreateServiceCallPage());

//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(
//               child: Text("No route is configured"),
//             ),
//           ),
//         );
//     }
//   }
// }
