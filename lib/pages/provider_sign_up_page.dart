import 'package:firebase_auth/firebase_auth.dart';
//import 'package:help_app/pages/home_page.dart';
import 'package:help_app/pages/home_page_provider.dart';
import 'package:help_app/pages/sign_in_page.dart';
import 'package:help_app/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:help_app/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderSignUpPage extends StatefulWidget {
  const ProviderSignUpPage({super.key});

  @override
  State<ProviderSignUpPage> createState() => _ProviderSignUpPageState();
}

List<String> categories = ["Category 1", "Category 2", "Category 3"];
String? _selectedCategory; // variable to hold the selected category

class _ProviderSignUpPageState extends State<ProviderSignUpPage> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;

  // create instance of firenase authenticator
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // controllers for user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // decoration variables
  Color _emailBorderColor = Colors.black26;
  Color _passwordBorderColor = Colors.black26;

  // send user email and password to FireBase Auth
  Future<void> _signUpFunc(BuildContext context) async {
    try {
      // sign up the user
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      // store user data in 'users' firestore
      addUserDataToFirestore(
          _nameController.text, _emailController.text, _selectedCategory!);

      // Redirect to home page after successful sign-up
      Navigator.pushReplacement(
        context,
        // ignore: prefer_const_constructors
        MaterialPageRoute(builder: (context) => HomePageProvider()),
      );
    }
    // catch invalid sign up arguments
    on FirebaseAuthException catch (e) {
      // invalid email address
      if (e.code == 'invalid-email') {
        setState(() {
          _emailBorderColor = Colors.red;
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          _passwordBorderColor = Colors.red;
        });
      }
    }
    // handle errors
    catch (e) {
      // ignore: avoid_print
      print("error during sign up $e");
    }
  }

  // send user's data to FireStore db
  Future<void> addUserDataToFirestore(
      String name, String email, String category) async {
    // set connection to users collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // get userID from firebaseAuth
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // create new doc of user. set unique ID
    await users.add({
      'userId': userId,
      'name': name,
      'email': email,
      'category': category,
      'rating': "0",
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                // get started form
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // get started text
                      Text(
                        'be new Helper',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),

                      // divider
                      const SizedBox(
                        height: 40.0,
                      ),

                      // full name
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Full name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Full Name'),
                          hintText: 'Enter Full Name',
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

                      // email
                      TextFormField(
                        // set pwd text field border to black after input submited
                        onFieldSubmitted: (value) {
                          setState(() {
                            _emailBorderColor = Colors.black26;
                          });
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                            color: Colors.black12,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _emailBorderColor, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _emailBorderColor, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // divider
                      const SizedBox(
                        height: 25.0,
                      ),

                      // password
                      TextFormField(
                        // set pwd text field border to black after input submited
                        onFieldSubmitted: (value) {
                          setState(() {
                            _passwordBorderColor = Colors.black26;
                          });
                        },
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
                            borderSide: BorderSide(
                              color:
                                  _passwordBorderColor, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  _passwordBorderColor, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // divider
                      const SizedBox(
                        height: 25.0,
                      ),

                      // category; specialty
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        decoration: InputDecoration(
                          label: Text('Category'),
                          hintText: 'Select a category',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),

                      // divider
                      const SizedBox(
                        height: 25.0,
                      ),

                      // signup button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _signUpFunc(context);
                          },
                          child: const Text('Sign up'),
                        ),
                      ),

                      // divider
                      const SizedBox(
                        height: 30.0,
                      ),

                      // already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                // Call the asynchronous function and wait for it to complete
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignInPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // divider
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
