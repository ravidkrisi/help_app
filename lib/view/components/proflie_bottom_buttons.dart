import 'package:flutter/material.dart';
import 'package:help_app/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

Widget ProfileBottomButtons(BuildContext context) {
  return Consumer<ProfileViewModel>(
    builder: (context, profileViewModel, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              profileViewModel.signOut(context);
            },
            child: Column(
              children: [
                Icon(Icons.logout, size: 30),
                Text('Log out'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
