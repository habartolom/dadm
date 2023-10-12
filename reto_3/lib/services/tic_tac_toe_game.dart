import 'dart:math';
import 'package:reto_3/enums/game_status.dart';
import 'package:reto_3/models/movement_result.dart';

class TicTacToeGame {
  static const humanPlayer = 'X';
  static const computerPlayer = 'O';
  static const openSpot = ' ';
  static int computerScore = 0;
  static int humanScore = 0;
  static int tieScore = 0;
  static bool thereIsNoWinner = true;
  static bool isHumanTurn = true;
  static final board = List.filled(9, openSpot);

  void clearBoard() {
    thereIsNoWinner = true;

    for (var i = 0; i < board.length; i++) {
      board[i] = openSpot;
    }
  }

  void setMove(String player, int location) {
    if (thereIsNoWinner && board[location] == openSpot) {
      board[location] = player;
    }
  }

  int getComputerMove() {
    final openSpotIndexes = board
        .asMap()
        .entries
        .where((entry) => entry.value == openSpot)
        .map((entry) => entry.key)
        .toList();

    if (openSpotIndexes.isEmpty) {
      return -1;
    }

    final randomizer = Random();
    final randomIndex = randomizer.nextInt(openSpotIndexes.length);
    final index = openSpotIndexes[randomIndex];

    return index;
  }

  int checkForWinner() {
    // Check horizontal wins
    for (var i = 0; i <= 6; i += 3) {
      if (board[i] != openSpot &&
          board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2]) {
        return _updateGameAndReturnStatus(winner: board[i]);
      }
    }

    // Check vertical wins
    for (var i = 0; i <= 2; i++) {
      if (board[i] != openSpot &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        return _updateGameAndReturnStatus(winner: board[i]);
      }
    }

    // Check for diagonal wins
    if ((board[0] != openSpot &&
            board[0] == board[4] &&
            board[4] == board[8]) ||
        (board[2] != openSpot &&
            board[2] == board[4] &&
            board[4] == board[6])) {
      return _updateGameAndReturnStatus(winner: board[4]);
    }

    return _updateGameAndReturnStatus();
  }

  MovementResult resolveMove(squareIndex) {
    String infoText = '';

    setMove(TicTacToeGame.humanPlayer, squareIndex);
    int winner = checkForWinner();
    if (winner == 0) {
      infoText = "It's Computer's turn!";
      int move = getComputerMove();
      if (move != -1) {
        setMove(TicTacToeGame.computerPlayer, move);
      }
      winner = checkForWinner();
    }

    if (winner == GameStatus.notFinished.index) {
      infoText = "It's your turn.";
    } else if (winner == GameStatus.tie.index) {
      infoText = "It's a tie!";
    } else if (winner == GameStatus.humanWins.index) {
      infoText = "You won!";
    } else {
      infoText = "Computer won!";
    }

    String humanScoreText = 'Human: $humanScore';
    String computerScoreText = 'Computer: $computerScore';
    String tieScoreText = 'Ties: $tieScore';

    return MovementResult(
        information: infoText,
        humanScore: humanScoreText,
        computerScore: computerScoreText,
        tieScore: tieScoreText);
  }

  int _updateGameAndReturnStatus({String? winner}) {
    int gameStatus = GameStatus.notFinished.index;
    thereIsNoWinner = winner == null;

    if (winner == humanPlayer) {
      humanScore++;
      gameStatus = GameStatus.humanWins.index;
    } else if (winner == computerPlayer) {
      computerScore++;
      gameStatus = GameStatus.computerWins.index;
    } else {
      if (!board.any((element) => element == openSpot)) {
        tieScore++;
        gameStatus = GameStatus.tie.index;
      }
    }

    return gameStatus;
  }
}
