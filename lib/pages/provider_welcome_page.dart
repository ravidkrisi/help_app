import 'package:help_app/pages/customer_welcome_page.dart';
import 'package:help_app/pages/provider_sign_up_page.dart';
import 'package:help_app/pages/review_page.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/pages/sign_in_route.dart';
import 'package:help_app/widgets/custom_button.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/customer_sign_up_page.dart';

class ProviderWelcomePage extends StatelessWidget {
  const ProviderWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          // header
          Flexible(
              flex: 8,
              child: Column(
                children: [
                  // switch userRole button; redirect provider to customer welcome page
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerWelcomePage()),
                    ),
                    child: Text(
                      "Are you a customer? Click here",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 40.0,
                    ),
                    child: Center(
                      // logo
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'HELPAPP\n',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            TextSpan(
                                //text: '\logo here? diff background?',
                                style: TextStyle(
                              fontSize: 20,
                              // height: 0,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),

          // buttons
          const Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    // sign in button
                    Expanded(
                      child: WelcomButton("sign in", SignInAuth(),
                          Colors.transparent, Colors.black),
                    ),
                    Expanded(
                      // sign up button
                      child: WelcomButton("sign up", ProviderSignUpPage(),
                          Color.fromARGB(255, 96, 52, 171), Colors.white),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
