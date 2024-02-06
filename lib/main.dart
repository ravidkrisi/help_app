import 'package:firebase_core/firebase_core.dart';
import 'package:help_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/home_page_customer.dart';
import 'package:help_app/pages/provider_profile.dart';
import 'package:help_app/pages/review_page.dart';
import 'package:help_app/pages/customer_welcome_page.dart';
import 'package:help_app/pages/home_page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomerWelcomePage(),
    );
  }
}
