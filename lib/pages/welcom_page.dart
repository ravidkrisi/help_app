import 'package:help_app/pages/sign_in_route.dart';
import 'package:help_app/widgets/custom_button.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:help_app/pages/sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
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
              )),
          const Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                      child: WelcomButton("sign in", SignInAuth(),
                          Colors.transparent, Colors.black),
                    ),
                    Expanded(
                      child: WelcomButton("sign up", SignUpPage(),
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
