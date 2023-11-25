import 'package:flutter/material.dart';

class ScorePlayerWidget extends StatefulWidget {
  const ScorePlayerWidget({
    super.key,
    required this.score,
    required this.assetImage,
  });

  final int score;
  final String assetImage;

  @override
  State<ScorePlayerWidget> createState() => _ScorePlayerState();
}

class _ScorePlayerState extends State<ScorePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          widget.assetImage,
          width: 35,
          height: 35,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          '${widget.score}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gabriela',
          ),
        ),
      ],
    );
  }
}
