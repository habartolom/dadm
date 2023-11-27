import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';

class WaitingReMatchScreen extends StatelessWidget {
  const WaitingReMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/angry_birds_waiting_rematch_icon.png",
                  height: screenSize.height * 0.6,
                ),
                const Text(
                  'Waiting for Confirmation',
                  style: TextStyle(
                    fontFamily: 'Gabriela',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 35, 110, 240),
                  ),
                ),
                const Text(
                  'The other player must confirm to play again',
                  style: TextStyle(
                    fontFamily: 'Gabriela',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name == NavigatorRoutes.homeRoute),
                      NavigatorRoutes.navigateToHome(context),
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 10, 54, 90),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: 'Gabriela',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
