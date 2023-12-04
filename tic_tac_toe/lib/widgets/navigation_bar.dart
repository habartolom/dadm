import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/enums/game_difficulty_level.dart';
import 'package:tic_tac_toe/services/bot_service.dart';
import 'package:tic_tac_toe/widgets/difficulty_dialog.dart';

class NavigationBarWidget extends StatefulWidget {
  final GameDifficultyLevelEnum difficultyLevel;
  final Function() onNewGame;
  const NavigationBarWidget(
      {super.key, required this.onNewGame, required this.difficultyLevel});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  GameDifficultyLevelEnum selectedDifficulty =
      GameDifficultyLevelEnum.easy; // Inicializa con Easy por defecto

  Future<void> _showQuitDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to quit?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Cerrar la aplicación si se selecciona "Yes"
                Navigator.of(context).pop();
                // Puedes utilizar esta línea o cualquier otra forma de cerrar la aplicación
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                // Cerrar el diálogo si se selecciona "No"
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.replay),
          label: 'New Game',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: 'Difficulty',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.info),
        //   label: 'About',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Quit',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          widget.onNewGame();
        }
        if (index == 1) {
          showDialog(
            context: context,
            builder: (context) {
              return DifficultyDialogWidget(
                difficultyLevel: widget.difficultyLevel,
                onChanged: (GameDifficultyLevelEnum value) {
                  BotService.match!.difficultyLevel = value;
                },
              );
            },
          );
        }
        if (index == 2) {
          _showQuitDialog();
        }
      },
    );
  }
}
