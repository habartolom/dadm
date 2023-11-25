import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'TIC TAC TOE',
        style: TextStyle(
          // color: Color.fromARGB(255, 35, 110, 240),
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Gabriela',
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 35, 110, 240),
      elevation: 1,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
