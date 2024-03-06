import 'package:flutter/material.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/components/profile_rating_stars.dart';
import 'package:help_app/view/components/proflie_bottom_buttons.dart';
import 'package:help_app/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, _) {
        return Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // divider
                  SizedBox(height: 60),

                  // profile pic
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),

                  // divider
                  SizedBox(height: 80),

                  // name field
                  Text(
                    profileViewModel.userViewModel.user?.name ?? 'NA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // divider
                  SizedBox(height: 10),

                  // email field
                  Text(
                    "email: ${profileViewModel.userViewModel.user?.email ?? 'NA'}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  (profileViewModel.userViewModel.type == UserType.provider)
                      ?
                      // provider info
                      Column(children: [
                          SizedBox(height: 10),

                          FutureBuilder<num>(
                            future: profileViewModel.userViewModel
                                .rating, // Assuming this is your async getter for rating
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Show a loader while rating is being fetched
                              } else {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return buildBoldTextWithStars('Rating:',
                                      rating: snapshot.data);
                                }
                              }
                            },
                          ),
                          // divider
                          SizedBox(height: 10),

                          // total earning
                          FutureBuilder<num>(
                            future: profileViewModel.userViewModel
                                .totalEarning, // Assuming this is your async getter for rating
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Show a loader while rating is being fetched
                              } else {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text(
                                    "total earning: ${snapshot.data}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          // divider
                          SizedBox(height: 10),

                          // total earning
                          FutureBuilder<num>(
                            future: profileViewModel.userViewModel
                                .callsCount, // Assuming this is your async getter for rating
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Show a loader while rating is being fetched
                              } else {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text(
                                    "call count: ${snapshot.data}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              }
                            },
                          ),

                          // divider
                          SizedBox(height: 10),
                        ])
                      : Container()
                ],
              ),
            ),

            // divider
            const SizedBox(
              height: 80.0,
            ),

            // bottom navigator buttons bar
            ProfileBottomButtons(context),
          ],
        );
      },
    );
  }
}
