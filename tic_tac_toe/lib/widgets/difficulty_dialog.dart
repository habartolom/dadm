import 'package:flutter/material.dart';
import 'package:tic_tac_toe/enums/game_difficulty_level.dart';

class DifficultyDialogWidget extends StatefulWidget {
  final ValueChanged<GameDifficultyLevelEnum> onChanged;
  final GameDifficultyLevelEnum difficultyLevel;
  const DifficultyDialogWidget(
      {super.key, required this.difficultyLevel, required this.onChanged});

  @override
  State<DifficultyDialogWidget> createState() => _DifficultyDialogWidgetState();
}

class _DifficultyDialogWidgetState extends State<DifficultyDialogWidget> {
  GameDifficultyLevelEnum? selectedDifficulty;

  @override
  void initState() {
    super.initState();
    selectedDifficulty = widget.difficultyLevel;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a difficulty level:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDifficultyOption(context, GameDifficultyLevelEnum.easy),
          _buildDifficultyOption(context, GameDifficultyLevelEnum.harder),
          _buildDifficultyOption(context, GameDifficultyLevelEnum.expert),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onChanged(selectedDifficulty!);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 10, 54, 90),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        ElevatedButton(
          onPressed: () {
            widget.onChanged(selectedDifficulty!);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 10, 54, 90),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: const Text(
            "OK",
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultyOption(
      BuildContext context, GameDifficultyLevelEnum difficulty) {
    final Map<GameDifficultyLevelEnum, String> difficultyTextMap = {
      GameDifficultyLevelEnum.easy: 'Easy',
      GameDifficultyLevelEnum.harder: 'Harder',
      GameDifficultyLevelEnum.expert: 'Expert',
    };

    String difficultyText = difficultyTextMap[difficulty] ?? 'Easy';

    return RadioListTile(
      title: Text(
        difficultyText,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Gabriela',
        ),
      ),
      value: difficulty,
      groupValue: selectedDifficulty,
      onChanged: (GameDifficultyLevelEnum? value) {
        setState(() {
          selectedDifficulty = value!;
        });
      },
    );
  }
}
