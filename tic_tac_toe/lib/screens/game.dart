import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/services/tictactoe_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';
import 'package:tic_tac_toe/widgets/board.dart';
import 'package:tic_tac_toe/widgets/navigation_bar.dart';
import 'package:tic_tac_toe/widgets/score_bar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late StreamSubscription<DatabaseEvent> onGameChangedSubscription;
  late StreamSubscription<DatabaseEvent> onUserChangedSubscription;

  void onSquareTapped(int index) {
    // if (TicTacToeService.user!.id == TicTacToeService.match!.playerInTurn!.id) {
    TicTacToeService.resolveMove(index);
    // setState(() {});
    // }
  }

  void onListenGameChanged(String key) {
    print(key);
    if (key == 'status' && TicTacToeService.match!.status == 'finished') {
      NavigatorRoutes.navigateToHome(context);
    }
  }

  void onListenUserChanged(String key) {
    print(key);
    if (key == 'status' && TicTacToeService.match!.status == 'online') {
      NavigatorRoutes.navigateToHome(context);
    }
  }

  void onFinishGame() async {
    await TicTacToeService.finishMatchAsync();
  }

  @override
  void initState() {
    super.initState();
    onGameChangedSubscription =
        TicTacToeService.listenGameChanged(onListenGameChanged);
    onUserChangedSubscription =
        TicTacToeService.listenUserChanged(onListenUserChanged);
    TicTacToeService.setBoard();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ScoreBarWidget(
              assetImagePlayer1: TicTacToeService.match!.player1!.character!,
              assetImagePlayer2: TicTacToeService.match!.player2!.character!,
              scorePlayer1: TicTacToeService.match!.score!.wonMatchesPlayer1,
              scorePlayer2: TicTacToeService.match!.score!.wonMatchesPlayer2,
              ties: TicTacToeService.match!.score!.drawnMatches,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "May the best win!",
                    style: TextStyle(
                      fontFamily: 'Gabriela',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: BoardWidget(
                      board: TicTacToeService.grid!,
                      onSquareTapped: onSquareTapped,
                    ),
                  ),
                  buildTurnInfo(),
                  buildTurnButtons(),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const NavigationBarWidget(),
      ),
    );
  }

  Widget buildTurnInfo() {
    if (TicTacToeService.match!.status != 'completed') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            TicTacToeService.match!.playerInTurn!.character!,
            width: 80,
            height: 80,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "It's your TURN!",
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 35, 110, 240),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            TicTacToeService.match!.playerInTurn!.character!,
            width: 80,
            height: 80,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Is the WINNER!",
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 35, 110, 240),
            ),
          ),
        ],
      );
    }
  }

  Widget buildTurnButtons() {
    if (TicTacToeService.match!.status != 'completed') {
      return SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () => {NavigatorRoutes.navigateToHome(context)},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 10, 54, 90),
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 10.0,
              bottom: 10.0,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: const Text(
            "Surrender",
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
            ),
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => {
                TicTacToeService.cleanBoard(),
                NavigatorRoutes.navigateToWaitingReMatch(context)
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 10, 54, 90),
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                "Again",
                style: TextStyle(
                  fontFamily: 'Gabriela',
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => {
                onFinishGame(),
                Navigator.popUntil(
                    context,
                    (route) =>
                        route.settings.name == NavigatorRoutes.homeRoute),
                NavigatorRoutes.navigateToHome(context),
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 10, 54, 90),
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                "Finish",
                style: TextStyle(
                  fontFamily: 'Gabriela',
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
