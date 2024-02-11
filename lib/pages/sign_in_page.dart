import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/objects/user.dart';
import 'package:help_app/pages/customer_sign_up_page.dart';
import 'package:help_app/pages/home_page_customer.dart';
import 'package:help_app/pages/home_page_provider.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:help_app/theme/theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign in function
  void signInFunc() async {
    try {
      // Sign in user with email and password
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If sign-in is successful, navigate to home page
      if (userCredential.user != null) {
        // check the role of the user
        String? userId = FirebaseAuth.instance.currentUser?.uid;
        AppUser? curr_user = await AppUser.getUserById(userId);
        int type = 0;

        if (curr_user != null) {
          type = curr_user.type;
          print(type);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  (type == 2) ? HomePageCustomer() : HomePageProvider()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific authentication errors
      String errorMessage =
          'Incorrect email or password. Please check and try again.';

      // Show error message in a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Catch any other errors and print them
      print("Error during sign in: $e");

      // Show a generic error message in a snackbar
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content:
      //         Text('An error occurred during sign-in. Please try again later.'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  // dispose controller to help memory management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black), // Set the back arrow color to black
        // other app bar properties
      ),
      body: CustomScaffold(
        child: Column(
          children: [
            const Expanded(flex: 2, child: SizedBox(height: 10)),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 80, 25, 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formSignInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // header
                        Text(
                          'Welcome back to HELPAPP',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                            color: lightColorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // email textfield
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: const Text('Email'),
                              hintText: 'Enter Email',
                              hintStyle: const TextStyle(
                                color: Colors.black26,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black26),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),

                        // divider
                        const SizedBox(
                          height: 25.0,
                        ),

                        // password textfield
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // divider
                        const SizedBox(
                          height: 25.0,
                        ),

                        // sign in button
                        GestureDetector(
                          onTap: signInFunc,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                                child: Text(
                              "sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),

                        // divider
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (e) => const CustomerSignUpPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
