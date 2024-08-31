import 'package:flutter/material.dart';
import 'package:help_app/view/components/bottom_bar.dart';
import 'package:help_app/view/components/service_call_list.dart';
import 'package:provider/provider.dart';
import 'package:help_app/view_model/home_view_model.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        return MaterialApp(
          title: 'Your App Title',
          home: Scaffold(
            appBar: AppBar(
              title: Text('In Progress'),
            ),
            body: Padding(
                padding: EdgeInsets.all(16),
                child: ServiceCallListWidget(pageType: 3)),
            bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 3),
          ),
        );
      },
    );
  }
}
