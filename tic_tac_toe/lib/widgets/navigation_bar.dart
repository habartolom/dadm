import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.replay),
        label: 'New Game',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.sports_esports),
        label: 'Difficulty',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info),
        label: 'About',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.logout),
      //   label: 'Quit',
      // ),
    ]);
  }
}
