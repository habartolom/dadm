import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/services/tictactoe_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';
import 'package:tic_tac_toe/widgets/navigation_bar.dart';

class AvailableGamesScreen extends StatefulWidget {
  const AvailableGamesScreen({super.key});

  @override
  State<AvailableGamesScreen> createState() => _AvailableGamesScreenState();
}

class _AvailableGamesScreenState extends State<AvailableGamesScreen> {
  void startNewGame() async {
    await TicTacToeService.startNewGame();
  }

  void startAvailableGame(int index) async {
    await TicTacToeService.startAvailableGame(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: TicTacToeService.availableMatches!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    startAvailableGame(index);
                    NavigatorRoutes.navigateToChooseCharacter(context);
                  },
                  child: ListTile(
                    title: Text(
                        'ID del Juego: ${TicTacToeService.availableMatches![index].number}'),
                    // subtitle: Text(
                    //   'Estadísticas del Jugador:\n'
                    //   'Ganados: ${availableGames[index].player1?.statistics?.wonMatches ?? 0}\n'
                    //   'Perdidos: ${availableGames[index].player1?.statistics?.lostMatches ?? 0}\n'
                    //   'Empatados: ${availableGames[index].player1?.statistics?.tiedMatches ?? 0}\n'
                    //   'Abandonados: ${availableGames[index].player1?.statistics?.abandonedMatches ?? 0}',
                    // ),
                    subtitle: const Text(
                      'Estadísticas del Jugador:\n'
                      'Ganados: 0\n'
                      'Perdidos: 0\n'
                      'Empatados: 0\n'
                      'Abandonados: 0',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () => {
                startNewGame(),
                NavigatorRoutes.navigateToChooseCharacter(context),
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
                "Start a new game",
                style: TextStyle(
                  fontFamily: 'Gabriela',
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
