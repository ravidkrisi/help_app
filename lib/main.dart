import 'package:firebase_core/firebase_core.dart';
import 'package:help_app/firebase_options.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/pages/sign_in_route.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/welcom_page.dart';

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
      home: WelcomePage(),
    );
  }
}
