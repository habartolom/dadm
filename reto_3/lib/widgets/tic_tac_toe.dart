//create a class named TicTacToe and a private property called game with type TicTacToeGame
import 'package:flutter/material.dart';
import 'package:reto_3/models/movement_result.dart';
import 'package:reto_3/widgets/board.dart';
import 'package:reto_3/services/tic_tac_toe_game.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final TicTacToeGame game = TicTacToeGame();
  String infoText = '';
  String humanScore = 'Human: 0';
  String computerScore = 'Computer: 0';
  String tieScore = 'Ties: 0';

  void onSquareTapped(int index) {
    if (TicTacToeGame.thereIsNoWinner &&
        TicTacToeGame.board[index] == TicTacToeGame.openSpot) {
      MovementResult movementResult = game.resolveMove(index);
      infoText = movementResult.information;
      humanScore = movementResult.humanScore;
      computerScore = movementResult.computerScore;
      tieScore = movementResult.tieScore;
      setState(() {});
    }
  }

  void onNewGameButtonPressed() {
    infoText = '';
    game.clearBoard();

    if (!TicTacToeGame.isHumanTurn) {
      int move = game.getComputerMove();
      game.setMove(TicTacToeGame.computerPlayer, move);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: Scaffold(
        body: Container(
          color: const Color(0xFF282c36),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50.0),
                const Text(
                  'Tic Tac Toe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Board(
                      board: TicTacToeGame.board,
                      onSquareTapped: onSquareTapped,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  infoText,
                  style: TextStyle(
                    color: TicTacToeGame.thereIsNoWinner
                        ? Colors.white
                        : Colors.orange,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      humanScore,
                      style: const TextStyle(
                        color: Color(0xFFFF5733),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      tieScore,
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      computerScore,
                      style: const TextStyle(
                        color: Color(0xFF338DFF),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: onNewGameButtonPressed,
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(200, 60)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF49505A)),
                  ),
                  child: const Text(
                    'New Game',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
