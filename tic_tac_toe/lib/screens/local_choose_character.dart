import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/services/bot_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';
import 'package:tic_tac_toe/widgets/character_grid.dart';

class LocalChooseCharacterScreen extends StatefulWidget {
  const LocalChooseCharacterScreen({super.key});

  @override
  State<LocalChooseCharacterScreen> createState() =>
      _LocalChooseCharacterScreenState();
}

class _LocalChooseCharacterScreenState
    extends State<LocalChooseCharacterScreen> {
  int? selectedCharacterIndex;

  void onTapGoToMatchButton() {
    if (selectedCharacterIndex != null) {
      BotService.setCharacterPlayer(selectedCharacterIndex!);
    }
  }

  void onCharacterTapped(int index) {
    setState(() {
      if (selectedCharacterIndex != null) {
        BotService.characters[selectedCharacterIndex!].backgroundColor =
            Colors.blueGrey;
      }

      selectedCharacterIndex = index;
      BotService.characters[selectedCharacterIndex!].backgroundColor =
          const Color.fromARGB(255, 146, 201, 233);
    });
  }

  @override
  void initState() {
    super.initState();
    for (var character in BotService.characters) {
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
                characters: BotService.characters,
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
                      onTapGoToMatchButton(),
                      if (selectedCharacterIndex != null)
                        {
                          Navigator.pop(context),
                          NavigatorRoutes.navigateToLocalBoard(context),
                        }
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
      ),
    );
  }
}
