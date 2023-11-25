import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/models/square.dart';
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
  final List<SquareModel> board = List.generate(
    9,
    (index) => SquareModel(
      index: index,
      backgroundColor: Colors.blueGrey,
      assetImage: "assets/images/angry_blue_bird_icon.png",
    ),
  );

  void onSquareTapped(int index) {
    board[index].assetImage = 'assets/images/angry_red_bird_icon.png';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const ScoreBarWidget(
              assetImagePlayer1: 'assets/images/angry_red_bird_icon.png',
              assetImagePlayer2: 'assets/images/angry_blue_bird_icon.png',
              scorePlayer1: 5,
              scorePlayer2: 2,
              ties: 4,
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
                      board: board,
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
                        "assets/images/angry_red_bird_icon.png",
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
