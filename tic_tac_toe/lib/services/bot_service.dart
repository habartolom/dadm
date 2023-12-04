import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/data/moves.dart';
import 'package:tic_tac_toe/enums/game_difficulty_level.dart';
import 'package:tic_tac_toe/enums/game_status.dart';
import 'package:tic_tac_toe/enums/game_winner.dart';
import 'package:tic_tac_toe/models/character.dart';
import 'package:tic_tac_toe/models/match.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/models/score.dart';
import 'package:tic_tac_toe/models/square.dart';

class BotService {
  static MatchModel? match;
  static List<CharacterModel> characters = [
    CharacterModel(
        id: 0,
        assetImage: "assets/images/angry_blue_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 1,
        assetImage: "assets/images/angry_red_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 2,
        assetImage: "assets/images/angry_yellow_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 3,
        assetImage: "assets/images/angry_green_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 4,
        assetImage: "assets/images/angry_black_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 5,
        assetImage: "assets/images/angry_white_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 6,
        assetImage: "assets/images/angry_magenta_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 7,
        assetImage: "assets/images/angry_blue_scary_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 8,
        assetImage: "assets/images/angry_pink_female_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 9,
        assetImage: "assets/images/angry_red_female_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 10,
        assetImage: "assets/images/angry_green_pig_bird_icon.png",
        backgroundColor: Colors.blueGrey),
    CharacterModel(
        id: 11,
        assetImage: "assets/images/angry_red_baby_bird_icon.png",
        backgroundColor: Colors.blueGrey),
  ];
  static List<SquareModel>? grid;
  static const openSpot = 'assets/images/blank_icon.png';

  static void startNewGame() {
    match ??= MatchModel(
      score: ScoreModel(
          drawnMatches: 0, wonMatchesPlayer1: 0, wonMatchesPlayer2: 0),
      difficultyLevel: GameDifficultyLevelEnum.expert,
    );
    cleanBoard();
  }

  static void setCharacterPlayer(int characterId) async {
    String assetPlayer1 = characters.elementAt(characterId).assetImage;

    var remainingCharacters = characters
        .where((element) => element.id != characterId)
        .toList(growable: false);

    var random = Random();
    String assetPlayer2 = remainingCharacters
        .elementAt(random.nextInt(remainingCharacters.length))
        .assetImage;

    match!.player1 = PlayerModel(id: 'player_1', character: assetPlayer1);
    match!.player2 = PlayerModel(id: 'player_2', character: assetPlayer2);
    match!.currentPlayer = match!.player1;
    match!.status = GameStatusEnum.inProgress;
  }

  static void finishMatch() {
    match!.status = GameStatusEnum.ready;
    cleanBoard();
  }

  static void onPlayerSurrender() {
    match!.status = GameStatusEnum.ready;
    match!.score!.wonMatchesPlayer2++;
    cleanBoard();
  }

  static void onRematch() {
    match!.status = GameStatusEnum.inProgress;
    cleanBoard();
    setInitialPlayer();
  }

  static void cleanBoard() {
    match!.board = List.generate(9, (index) => openSpot);
    match!.winner = null;
    setGrid();
  }

  static void setGrid() {
    grid = List.generate(
      match!.board!.length,
      (index) => SquareModel(
        index: index,
        backgroundColor: Colors.blueGrey,
        assetImage: match!.board![index]!,
      ),
    );
  }

  static String? checkForWinner() {
    String? winner;
    final board = match!.board;
    Color backgroundColor = const Color.fromARGB(255, 46, 110, 207);

    for (var i = 0; i <= 6; i += 3) {
      if (board![i] != openSpot &&
          board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2]) {
        grid![i].backgroundColor = backgroundColor;
        grid![i + 1].backgroundColor = backgroundColor;
        grid![i + 2].backgroundColor = backgroundColor;
        winner = grid![i].assetImage;
        match!.status = GameStatusEnum.completed;
        break;
      }
    }

    // Check vertical wins
    for (var i = 0; i <= 2; i++) {
      if (board![i] != openSpot &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        grid![i].backgroundColor = backgroundColor;
        grid![i + 3].backgroundColor = backgroundColor;
        grid![i + 6].backgroundColor = backgroundColor;
        winner = grid![i].assetImage;
        match!.status = GameStatusEnum.completed;
        break;
      }
    }

    // Check for diagonal wins
    if (board![0] != openSpot && board[0] == board[4] && board[4] == board[8]) {
      grid![0].backgroundColor = backgroundColor;
      grid![4].backgroundColor = backgroundColor;
      grid![8].backgroundColor = backgroundColor;
      winner = grid![0].assetImage;
      match!.status = GameStatusEnum.completed;
    }

    if (board[2] != openSpot && board[2] == board[4] && board[4] == board[6]) {
      grid![2].backgroundColor = backgroundColor;
      grid![4].backgroundColor = backgroundColor;
      grid![6].backgroundColor = backgroundColor;
      winner = grid![2].assetImage;
      match!.status = GameStatusEnum.completed;
    }

    if (match!.status != GameStatusEnum.completed &&
        !match!.board!.contains(openSpot)) {
      winner = 'tie';
      match!.status = GameStatusEnum.completed;
    }

    return winner;
  }

  static void setScore(String winner) {
    if (winner == 'tie') {
      match!.score!.drawnMatches++;
      match!.winner = GameWinnerEnum.none;
    } else if (match!.player1!.character == winner) {
      match!.score!.wonMatchesPlayer1++;
      match!.winner = GameWinnerEnum.player1;
    } else {
      match!.score!.wonMatchesPlayer2++;
      match!.winner = GameWinnerEnum.player2;
    }
  }

  static int getRandomMove() {
    final availableSpots = match!.board!
        .asMap()
        .entries
        .where((entry) => entry.value == openSpot)
        .map((entry) => entry.key)
        .toList();

    var random = Random();
    int index = availableSpots.elementAt(random.nextInt(availableSpots.length));
    return index;
  }

  static int getBlockingMove() {
    int move = -1;
    return move;
  }

  static int getWinningMove(PlayerModel player) {
    int move = -1;

    List<int> event = match!.board!
        .asMap()
        .entries
        .where((entry) => entry.value == player.character)
        .map((entry) => entry.key)
        .toList();

    List<int> availableSpots = match!.board!
        .asMap()
        .entries
        .where((entry) => entry.value == openSpot)
        .map((entry) => entry.key)
        .toList();

    List<Map<String, List<int>>> result = Moves.data.where((item) {
      List<int> filledSpots = item["filledSpots"] ?? [];
      List<int> freeSpots = item["freeSpots"] ?? [];

      return filledSpots.every((spot) => event.contains(spot)) &&
          freeSpots.every((spot) => availableSpots.contains(spot));
    }).toList();

    if (result.isNotEmpty) {
      var random = Random();
      var winnermove = result.elementAt(random.nextInt(result.length));

      move = winnermove["freeSpots"]?.first ?? -1;
    }

    return move;
  }

  static int getComputerMove() {
    int move = -1;
    if (match!.difficultyLevel == GameDifficultyLevelEnum.easy) {
      move = getRandomMove();
    } else if (match!.difficultyLevel == GameDifficultyLevelEnum.harder) {
      move = getWinningMove(match!.player2!); //winning move
      if (move == -1) {
        move = getRandomMove();
      }
    } else if (match!.difficultyLevel == GameDifficultyLevelEnum.expert) {
      move = getWinningMove(match!.player2!); //winning move
      if (move == -1) {
        move = getWinningMove(match!.player1!); // blocking move
      }
      if (move == -1) {
        move = getRandomMove();
      }
    }
    return move;
  }

  static void resolveBotMove() async {
    int index = getComputerMove();
    match!.board![index] = match!.player2!.character;
    setGrid();
    String? winner = checkForWinner();
    if (winner == null) {
      match!.currentPlayer = match!.player1;
    } else {
      setScore(winner);
    }
  }

  static void setInitialPlayer() async {
    if (match?.initialPlayer == null ||
        match?.initialPlayer == match?.player2) {
      match!.initialPlayer = match!.player1;
      match!.currentPlayer = match!.player1;
    } else {
      match!.initialPlayer = match!.player2;
      match!.currentPlayer = match!.player2;
      resolveBotMove();
    }
  }

  static Future<void> resolvePlayerMove(int index) async {
    if (match!.status != GameStatusEnum.completed &&
        match!.board![index] == openSpot) {
      match!.board![index] = match!.currentPlayer!.character;
      setGrid();

      String? winner = checkForWinner();
      if (winner == null) {
        match!.currentPlayer = match!.player2;
        resolveBotMove();
      } else {
        setScore(winner);
      }
    }
  }
}
