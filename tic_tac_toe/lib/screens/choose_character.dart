import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/services/tictactoe_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';
import 'package:tic_tac_toe/widgets/character_grid.dart';
import 'package:tic_tac_toe/widgets/navigation_bar.dart';

class ChooseCharacterScreen extends StatefulWidget {
  const ChooseCharacterScreen({super.key});

  @override
  State<ChooseCharacterScreen> createState() => _ChooseCharacterScreenState();
}

class _ChooseCharacterScreenState extends State<ChooseCharacterScreen> {
  int? selectedCharacterIndex;

  void onTapGoToMatchButton(BuildContext context) async {
    if (selectedCharacterIndex != null) {
      await TicTacToeService.setCharacterPlayer(selectedCharacterIndex!);
      NavigatorRoutes.navigateToWaitingMatch(context);
    }
  }

  void onCharacterTapped(int index) {
    setState(() {
      if (selectedCharacterIndex != null) {
        TicTacToeService.characters[selectedCharacterIndex!].backgroundColor =
            Colors.blueGrey;
      }

      selectedCharacterIndex = index;
      TicTacToeService.characters[selectedCharacterIndex!].backgroundColor =
          const Color.fromARGB(255, 146, 201, 233);
    });
  }

  @override
  void initState() {
    super.initState();
    for (var character in TicTacToeService.characters) {
      character.backgroundColor = Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Choose your character",
              style: TextStyle(
                fontFamily: 'Gabriela',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              child: CharacterGridWidget(
                characters: TicTacToeService.characters,
                onCharacterTapped: onCharacterTapped,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () => {
                      onTapGoToMatchButton(context),
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
                      "Go to match",
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
                    onPressed: () => {},
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
          ],
        ),
        bottomNavigationBar: const NavigationBarWidget(),
      ),
    );
  }
}
