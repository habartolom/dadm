import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/square.dart';
import 'package:tic_tac_toe/widgets/square.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({
    super.key,
    required this.board,
    required this.onSquareTapped,
  });

  final List<SquareModel> board;
  final Function(int) onSquareTapped;

  @override
  State<BoardWidget> createState() => _BoardState();
}

class _BoardState extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return SquareWidget(
          backgroundColor: widget.board[index].backgroundColor,
          assetImage: widget.board[index].assetImage,
          onTap: () => widget.onSquareTapped(index),
        );
      },
    );
  }
}
