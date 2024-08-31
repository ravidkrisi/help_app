//
import 'package:flutter/material.dart';
import 'package:help_app/view/components/bottom_bar.dart';
import 'package:help_app/view/components/service_call_list.dart';
import 'package:help_app/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        return MaterialApp(
          title: 'Your App Title',
          home: Scaffold(
            appBar: AppBar(
              title: Text('History'),
            ),
            body: Padding(
                padding: EdgeInsets.all(16),
                child: ServiceCallListWidget(pageType: 2)),
            bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
          ),
        );
      },
    );
  }
}
