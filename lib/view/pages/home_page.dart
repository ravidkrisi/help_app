//
import 'package:flutter/material.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/components/bottom_bar.dart';
import 'package:help_app/view/components/service_call_list.dart';
import 'package:help_app/view/pages/create_service_call_page.dart';
import 'package:help_app/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        return MaterialApp(
          title: 'Your App Title',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: ServiceCallListWidget(
                pageType: 0,
              ),
            ),

            floatingActionButton:
                (homeViewModel.getUserType() == UserType.customer)
                    ? FloatingActionButton(
                        onPressed: () {
                          // Navigate to the CreateServiceCallPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateServiceCallPage()),
                          );
                        },
                        child: Icon(Icons.add),
                      )
                    : Container(),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .miniEndFloat, // Align the button to the bottom left

            bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
          ),
        );
      },
    );
  }
}
