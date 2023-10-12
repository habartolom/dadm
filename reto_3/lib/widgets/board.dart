import 'package:flutter/material.dart';
import 'package:reto_3/widgets/square.dart';
import '../services/tic_tac_toe_game.dart';

class Board extends StatefulWidget {
  final List<String> board;
  final Function(int) onSquareTapped;

  const Board({
    Key? key,
    required this.board,
    required this.onSquareTapped,
  }) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Color _getTextColor(int index) {
    Color textColor = widget.board[index] == TicTacToeGame.humanPlayer
        ? Colors.red
        : Colors.blue;
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => widget.onSquareTapped(index),
          child: Square(
            text: widget.board[index],
            color: _getTextColor(index),
            onTap: () => widget.onSquareTapped(index),
          ),
        );
      },
    );
  }
}
