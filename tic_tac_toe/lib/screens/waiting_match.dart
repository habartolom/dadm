import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/services/tictactoe_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';

class WaitingMatchScreen extends StatefulWidget {
  const WaitingMatchScreen({super.key});

  @override
  State<WaitingMatchScreen> createState() => _WaitingMatchScreenState();
}

class _WaitingMatchScreenState extends State<WaitingMatchScreen> {
  late StreamSubscription<DatabaseEvent> onEntryChangedSubscription;

  @override
  void initState() {
    super.initState();

    onEntryChangedSubscription =
        TicTacToeService.listenGameChanged(onListenGameChanged);
  }

  onListenGameChanged(String key) async {
    if (key == 'status' && TicTacToeService.match!.status == 'in progress') {
      NavigatorRoutes.navigateToBoard(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int gameNumber = TicTacToeService.match!.number!;
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
                  "assets/images/angry_birds_waiting_match_icon.png",
                ),
                Text(
                  'Your game is number $gameNumber',
                  style: const TextStyle(
                    fontFamily: 'Gabriela',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 35, 110, 240),
                  ),
                ),
                const Text(
                  'Wait for another player to join the game to start',
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
                      {NavigatorRoutes.navigateToBoard(context)},
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
