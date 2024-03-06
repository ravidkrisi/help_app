// import 'package:flutter/material.dart';
// import 'package:help_app/view/pages/history_page.dart';
// import 'package:help_app/view/pages/home_page.dart';
// import 'package:help_app/view/pages/in_progress_page.dart';
// import 'package:help_app/view/pages/profile_page.dart';

// class CustomBottomNavigationBar extends StatelessWidget {
//   final int currentIndex;

//   const CustomBottomNavigationBar({
//     Key? key,
//     required this.currentIndex,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       selectedItemColor: Colors.purple,
//       currentIndex: currentIndex,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.history),
//           label: 'History',
//         ),
//         //         BottomNavigationBarItem(
//         //   icon: Icon(Icons.timer),
//         //   label: 'In Progress',
//         // ),
//       ],
//       onTap: (index) {
//         switch (index) {
//           // home
//           case 0:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomePage(),
//               ),
//             );
//             break;

//           // profile
//           case 1:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProfilePage(),
//               ),
//             );
//             break;

//           // history
//           case 2:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HistoryPage(),
//               ),
//             );
//             break;

//           //    // in progress
//           // case 3:
//           //   Navigator.pushReplacement(
//           //     context,
//           //     MaterialPageRoute(
//           //       builder: (context) => InProgressPage(),
//           //     ),
//           //   );
//           //   break;
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:help_app/view/pages/history_page.dart';
import 'package:help_app/view/pages/home_page.dart';
import 'package:help_app/view/pages/profile_page.dart';
import 'package:help_app/view/pages/in_progress_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Color.fromARGB(255, 96, 102, 97),
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'In Progress',
        ),
      ],
      onTap: (index) {
        switch (index) {
          // home
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
            break;

          // profile
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
            break;

          // history
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryPage(),
              ),
            );
            break;

          // in progress
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InProgressPage(),
              ),
            );
            break;
        }
      },
    );
  }
}
