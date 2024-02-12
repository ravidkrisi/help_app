import 'package:help_app/pages/welcome_page_provider.dart';
import 'package:help_app/pages/review_page.dart';
import 'package:help_app/pages/service_call_page.dart';
import 'package:help_app/pages/sign_in_route.dart';
import 'package:help_app/widgets/custom_button.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/sign_up_page_customer.dart';

class CustomerWelcomePage extends StatelessWidget {
  const CustomerWelcomePage({super.key});

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
                  // switch userRole button; redirect customer to provider welcome page
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderWelcomePage()),
                    ),
                    child: Text(
                      "Are you a provider?\n Click here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        backgroundColor: Colors.white,
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
                                text: 'HelpApp\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            TextSpan(
                                style: TextStyle(
                              fontSize: 20,
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
                      child: WelcomButton("sign up", CustomerSignUpPage(),
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
