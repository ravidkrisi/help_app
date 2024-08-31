import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:help_app/model/service_call.dart';
import 'package:help_app/services/service_call_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/view/components/call_card.dart';
import 'package:help_app/view_model/user_view_model.dart'; // Import your UserViewModel

class ServiceCallListWidget extends StatelessWidget {
  // 0 home page
  // 2 history page
  final int pageType;

  ServiceCallListWidget({required this.pageType});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return StreamBuilder<List<ServiceCall>>(
          stream: userViewModel.type == UserType.provider
              ? (pageType == 0
                  ? ServiceCallService().getAllOpenServiceCallsStream()
                  : pageType == 2
                      ? ServiceCallService()
                          .getCompletedServiceCallsByProviderStream(
                              userViewModel.user!.uid)
                      : ServiceCallService()
                          .getInProgressServiceCallsByProviderStream(
                              userViewModel.user!.uid))
              : (pageType == 0
                  ? ServiceCallService().getOpenServiceCallsByCustomerStream(
                      userViewModel.user?.uid ?? '')
                  : pageType == 2
                      ? ServiceCallService()
                          .getCompletedServiceCallsByCustomerStream(
                              userViewModel.user!.uid)
                      : ServiceCallService()
                          .getInProgressServiceCallsByCustomerStream(
                              userViewModel.user!.uid)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List<ServiceCall> serviceCalls = snapshot.data!;

              if (serviceCalls.isEmpty) {
                return Center(
                  child: Text(
                    _getEmptyMessage(userViewModel.type, pageType),
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                itemCount: serviceCalls.length,
                itemBuilder: (context, index) {
                  final serviceCall = serviceCalls[index];
                  int btnType =
                      _determineButtonType(serviceCall, userViewModel.type);
                  return CallCard(
                    call: serviceCall,
                    btn_type: btnType,
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  int _determineButtonType(ServiceCall serviceCall, UserType userType) {
    // 0 no button
    // 1 take job
    // 2 leave review
    // 3 finish job

    if (userType == UserType.customer) {
      if (serviceCall.inProgress == false && serviceCall.isCompleted == false) {
        // task is open- no button
        return 0;
      }
      if (serviceCall.isCompleted == true && serviceCall.isReviewed == false) {
        return 2;
      }
    } else if (userType == UserType.provider) {
      if (serviceCall.isCompleted == false && serviceCall.inProgress == false) {
        // task is open
        return 1;
      }
      if (serviceCall.inProgress == true) {
        // task in progress from provider side
        return 3;
      }
      return 0;
    }
    return 0;
  }

  String _getEmptyMessage(UserType userType, int pageType) {
    if (userType == UserType.customer && pageType == 0) {
      return 'Create a new service call';
    } else if (userType == UserType.provider && pageType == 0) {
      return 'No available calls';
    } else {
      if (pageType == 2) {
        return 'No history';
      }

      return 'no call in progress';
    }
  }
}
