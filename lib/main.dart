import 'package:firebase_core/firebase_core.dart';
import 'package:help_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:help_app/view/pages/welcome_page.dart';
import 'package:help_app/view_model/home_view_model.dart';
import 'package:help_app/view_model/profile_view_model.dart';
import 'package:help_app/view_model/review_view_model.dart';
import 'package:help_app/view_model/service_call_view_model.dart';
import 'package:help_app/view_model/sign_in_view_model.dart';
import 'package:help_app/view_model/sign_up_view_model.dart';
import 'package:help_app/view_model/user_view_model.dart';
import 'package:help_app/view_model/welcome_page_view_model.dart';
import 'package:provider/provider.dart'; // Import provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ReviewViewModel()),
        ChangeNotifierProvider(
            create: (context) => WelcomePageViewModel(
                Provider.of<UserViewModel>(context, listen: false))),
        ChangeNotifierProvider(
            create: (context) => SignInViewModel(
                Provider.of<UserViewModel>(context, listen: false))),
        ChangeNotifierProvider(
            create: (context) => SignUpViewModel(
                Provider.of<UserViewModel>(context, listen: false))),
        ChangeNotifierProvider(
            create: (context) => ServiceCallViewModel(
                Provider.of<UserViewModel>(context, listen: false))),
        ChangeNotifierProvider(
            create: (context) => HomeViewModel(
                Provider.of<UserViewModel>(context, listen: false))),
        ChangeNotifierProvider(
            create: (context) => ProfileViewModel(
                Provider.of<UserViewModel>(context, listen: false))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: WelcomePage(),
    );
  }
}
