import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/enums/game_status.dart';
import 'package:tic_tac_toe/enums/game_winner.dart';
import 'package:tic_tac_toe/services/bot_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';
import 'package:tic_tac_toe/widgets/board.dart';
import 'package:tic_tac_toe/widgets/navigation_bar.dart';
import 'package:tic_tac_toe/widgets/score_bar.dart';

class LocalGameScreen extends StatefulWidget {
  const LocalGameScreen({
    super.key,
  });

  @override
  State<LocalGameScreen> createState() => _LocalGameScreenState();
}

class _LocalGameScreenState extends State<LocalGameScreen> {
  void onSquareTapped(int index) async {
    if (BotService.match!.player1 == BotService.match!.currentPlayer) {
      await BotService.resolvePlayerMove(index);
    }
    setState(() {});
  }

  void onFinishGame() {
    BotService.finishMatch();
  }

  void onRematch() {
    BotService.onRematch();
    setState(() {});
  }

  void onPlayerSurrender() {
    BotService.onPlayerSurrender();
  }

  void onStartNewGame() {
    BotService.startNewGame();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BotService.setInitialPlayer();
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
              assetImagePlayer1: BotService.match!.player1!.character!,
              assetImagePlayer2: BotService.match!.player2!.character!,
              scorePlayer1: BotService.match!.score!.wonMatchesPlayer1,
              scorePlayer2: BotService.match!.score!.wonMatchesPlayer2,
              ties: BotService.match!.score!.drawnMatches,
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
                      board: BotService.grid!,
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
        bottomNavigationBar: NavigationBarWidget(
          onNewGame: onStartNewGame,
          difficultyLevel: BotService.match!.difficultyLevel!,
        ),
      ),
    );
  }

  Widget buildTurnInfo() {
    if (BotService.match!.status != GameStatusEnum.completed) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            BotService.match!.currentPlayer!.character!,
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
          )
        ],
      );
    } else if (BotService.match!.status == GameStatusEnum.completed &&
        BotService.match!.winner == GameWinnerEnum.none) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                BotService.match!.player1!.character!,
                width: 80,
                height: 80,
              ),
              const SizedBox(
                width: 40,
              ),
              Image.asset(
                BotService.match!.player2!.character!,
                width: 80,
                height: 80,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "It's a TIE!",
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
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
            BotService.match!.currentPlayer!.character!,
            width: 80,
            height: 80,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Is the WINNER!',
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
    if (BotService.match!.status != GameStatusEnum.completed) {
      return SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () => {
            onPlayerSurrender(),
            Navigator.popUntil(context,
                (route) => route.settings.name == NavigatorRoutes.homeRoute),
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
                onRematch(),
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
