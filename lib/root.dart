import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/courts/views/court_details.dart';
import 'package:mala3bna/features/home/presentation/views/home_view.dart';
import 'package:mala3bna/features/messages/views/messages_view.dart';
import 'package:mala3bna/features/profile/views/profile_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController controller;
  late List<Widget> screens;
  int currentScreen = 0;

  @override
  void initState() {
    screens = [HomeView(), BookingsView(), MessagesView(), ProfileView()];
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0),

        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentScreen,

          onTap: (index) {
            setState(() {
              currentScreen = index;
            });
            controller.animateToPage(
              currentScreen,
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceInOut,
            );
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ticket),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline_rounded),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
