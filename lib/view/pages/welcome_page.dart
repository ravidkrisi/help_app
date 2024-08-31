import 'package:help_app/view/components/custom_scaffold.dart';
import 'package:help_app/view/components/welcome_button.dart';
import 'package:help_app/view_model/welcome_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WelcomePageViewModel>(builder: (context, viewModel, _) {
      return CustomScaffold(
        child: Column(
          children: [
            // header
            Flexible(
                flex: 8,
                child: Column(
                  children: [
                    // switch userRole button; redirect customer to provider welcome page
                    Text(
                      "welcome to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        backgroundColor: Colors.white,
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
                        child: WelcomButton(
                            "sign in", Colors.transparent, Colors.black),
                      ),
                      Expanded(
                        // sign up button
                        child: WelcomButton("sign up",
                            Color.fromARGB(255, 96, 52, 171), Colors.white),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    });
  }
}


// import 'package:flutter/material.dart';
// import 'package:help_app/pages/sign_in_page.dart';
// import 'package:help_app/view/components/custom_scaffold.dart';
// import 'package:help_app/view/components/welcome_button.dart';
// import 'package:help_app/view/pages/sign_up_page.dart';

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: Column(
//         children: [
//           // header
//           Flexible(
//               flex: 8,
//               child: Column(
//                 children: [
//                   // switch userRole button; redirect customer to provider welcome page
//                   // TextButton(
//                   //   onPressed:,
//                   //   child: Text(
//                   //     "Are you a provider?\n Click here",
//                   //     textAlign: TextAlign.center,
//                   //     style: TextStyle(
//                   //       color: Colors.black,
//                   //       fontSize: 28,
//                   //       backgroundColor: Colors.white,
//                   //     ),
//                   //   ),
//                   // ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 0,
//                       horizontal: 40.0,
//                     ),
//                     child: Center(
//                       // logo
//                       child: RichText(
//                         textAlign: TextAlign.center,
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                                 text: 'HelpApp\n',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 45.0,
//                                   fontWeight: FontWeight.w600,
//                                 )),
//                             TextSpan(
//                                 style: TextStyle(
//                               fontSize: 20,
//                             ))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
      
//           // buttons
//           const Flexible(
//               flex: 1,
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: Row(
//                   children: [
//                     // sign in button
//                     Expanded(
//                       child: WelcomeButton("sign in", SignInPage(),
//                           Colors.transparent, Colors.black),
//                     ),
//                     Expanded(
//                       // sign up button
//                       child: WelcomeButton("sign up", SignUpPage(),
//                           Color.fromARGB(255, 96, 52, 171), Colors.white),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
