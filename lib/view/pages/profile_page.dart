//
import 'package:flutter/material.dart';
import 'package:help_app/view/components/bottom_bar.dart';
import 'package:help_app/view/components/profile_list.dart';
import 'package:help_app/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, _) {
        return MaterialApp(
          title: 'Your App Title',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: ProfileList(),
            bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
          ),
        );
      },
    );
  }
}