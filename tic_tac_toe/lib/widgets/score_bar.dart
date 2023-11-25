import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/score_player.dart';

class ScoreBarWidget extends StatefulWidget {
  const ScoreBarWidget({
    super.key,
    required this.assetImagePlayer1,
    required this.assetImagePlayer2,
    required this.scorePlayer1,
    required this.scorePlayer2,
    required this.ties,
  });

  final String assetImagePlayer1;
  final String assetImagePlayer2;
  final int scorePlayer1;
  final int scorePlayer2;
  final int ties;

  @override
  State<ScoreBarWidget> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 146, 201, 233),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Score:",
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ScorePlayerWidget(
            score: widget.scorePlayer1,
            assetImage: widget.assetImagePlayer1,
          ),
          ScorePlayerWidget(
            score: widget.scorePlayer2,
            assetImage: widget.assetImagePlayer2,
          ),
          const Text(
            'Ties:',
            style: TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${widget.ties}',
            style: const TextStyle(
              fontFamily: 'Gabriela',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
