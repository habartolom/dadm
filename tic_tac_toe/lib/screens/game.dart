import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/models/square.dart';
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
  late StreamSubscription<DatabaseEvent> onEntryChangedSubscription;
  List<SquareModel>? board = TicTacToeService.grid;

  void onSquareTapped(int index) {
    // if (TicTacToeService.user!.id == TicTacToeService.match!.playerInTurn!.id) {
    TicTacToeService.resolveMove(index);
    // setState(() {});
    // }
  }

  void onlistenGameChanged() {
    board = TicTacToeService.grid;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onEntryChangedSubscription =
        TicTacToeService.listenGameChanged(onlistenGameChanged);
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
                    "Selecciona quien iniciará la partida",
                    style: TextStyle(
                      fontFamily: 'Gabriela',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: BoardWidget(
                      board: board!,
                      onSquareTapped: onSquareTapped,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "The turn is for the player ",
                        style: TextStyle(
                          fontFamily: 'Gabriela',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 35, 110, 240),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        TicTacToeService.match!.playerInTurn!.character!,
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () =>
                          {NavigatorRoutes.navigateToWinner(context)},
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
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const NavigationBarWidget(),
      ),
    );
  }
}
