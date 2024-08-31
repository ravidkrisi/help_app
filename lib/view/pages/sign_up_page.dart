import 'package:flutter/material.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/components/custom_scaffold.dart';
import 'package:help_app/view_model/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
        builder: (context, signUpViewModel, child) {
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
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // header
                        Text(
                          'Join our help community!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),

                        // user type dropdown
                        DropdownButtonFormField<UserType>(
                          value: signUpViewModel.userType,
                          onChanged: (UserType? newValue) {
                            signUpViewModel.setUserType(newValue!);
                          },
                          items: UserType.values.map((UserType userType) {
                            return DropdownMenuItem<UserType>(
                              value: userType,
                              child: Text(enumToString(userType)),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'User Type*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // divider
                        const SizedBox(height: 25.0),

                        // name field
                        TextFormField(
                          onChanged: (value) => signUpViewModel.setName(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Full name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Full Name*'),
                            hintText: 'Enter Full Name',
                            hintStyle: const TextStyle(
                              color: Colors.black12,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signUpViewModel
                                    .nameBorderColor, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signUpViewModel
                                    .nameBorderColor, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // divider
                        const SizedBox(height: 25.0),

                        // email field
                        TextFormField(
                          onChanged: (value) => signUpViewModel.setEmail(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            // Email format validation
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Email*'),
                            hintText: 'Enter Email',
                            hintStyle: const TextStyle(
                              color: Colors.black12,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signUpViewModel
                                    .emailBorderColor, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signUpViewModel
                                    .emailBorderColor, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // divider
                        const SizedBox(height: 25.0),

                        // password field
                        TextFormField(
                          onChanged: (value) =>
                              signUpViewModel.setPassword(value),
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            // Password strength validation
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Password*'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signUpViewModel
                                    .passwordBorderColor, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: signUpViewModel
                                    .passwordBorderColor, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // divider
                        const SizedBox(height: 25.0),

                        // sign up button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              signUpViewModel.signUpUser(context);
                            },
                            child: const Text('Sign up'),
                          ),
                        ),

                        // divider
                        const SizedBox(height: 30.0),

                        // sign in page redirect
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (e) => const SignInPage(),
                                //   ),
                                // );
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // divider
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
