import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/models/character.dart';
import 'package:tic_tac_toe/models/match.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/models/score.dart';
import 'package:tic_tac_toe/models/square.dart';
import 'package:tic_tac_toe/models/statistics.dart';
import 'package:tic_tac_toe/models/user.dart';
import 'package:tic_tac_toe/services/firebase_service.dart';

class TicTacToeService {
  static final FirebaseService _firebaseService = FirebaseService();
  static UserModel? user;
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
  static List<MatchModel>? availableMatches;

  static const openSpot = 'assets/images/blank_icon.png';

  static Future<UserModel?> getUserPlayerAsync() async {
    String? userId = await getSavedUserIdAsync();

    final newUser = UserModel(
      registrationDate: DateTime.now().toUtc(),
      status: 'online',
      statistics: StatisticsModel(
          wonMatches: 0, lostMatches: 0, tiedMatches: 0, abandonedMatches: 0),
    );

    if (userId == null) {
      await _firebaseService.registerUser(newUser);
      user = newUser;
      userId = user!.id!;
      await saveUserIdLocally(userId);
    }

    user ??= await _firebaseService.getUser(userId);
    if (user == null) {
      await _firebaseService.registerUser(newUser);
      user = newUser;
      userId = user!.id!;
      await saveUserIdLocally(userId);
    }

    return user;
  }

  static void setBoard() {
    grid ??= List.generate(
      match!.board!.length,
      (index) => SquareModel(
        index: index,
        backgroundColor: Colors.blueGrey,
        assetImage: match!.board![index]!,
      ),
    );
  }

  static Future<void> getMatchAsync() async {
    if (user!.match != null) {
      match = await _firebaseService.getMatchByIdAsync(user!.match!);
      grid = List.generate(
        match!.board!.length,
        (index) => SquareModel(
          index: index,
          backgroundColor: Colors.blueGrey,
          assetImage: match!.board![index]!,
        ),
      );
      highlightWinningMove();
    }
  }

  static Future<void> getAvailableMatchesAsync() async {
    availableMatches = await _firebaseService.getAvailableMatchesAsync();
  }

  static Future<void> startNewGame() async {
    int matchesCount = await _firebaseService.getMathesCount();
    PlayerModel player = PlayerModel(id: user!.id!);
    match = MatchModel(
      number: ++matchesCount,
      player1: player,
      status: 'pending',
      score: ScoreModel(
          drawnMatches: 0, wonMatchesPlayer1: 0, wonMatchesPlayer2: 0),
      playerInTurn: player,
      board: List.generate(9, (index) => openSpot),
    );
    await _firebaseService.startNewGame(match!);
    user?.match = match!.id;
    user?.status = 'choosing avatar';
    await _firebaseService.setUser(user!);
    await _firebaseService.setMatchesCount(matchesCount);
  }

  static Future<void> startAvailableGame(int index) async {
    match = availableMatches!.elementAt(index);
    match!.player2 = PlayerModel(id: user!.id!);

    user?.match = match!.id;
    user?.status = 'choosing avatar';

    await _firebaseService.setMatch(match!);
    await _firebaseService.setUser(user!);
  }

  static Future<String?> getSavedUserIdAsync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  static Future<void> saveUserIdLocally(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  static Future<void> setCharacterPlayer(int characterId) async {
    String character = characters.elementAt(characterId).assetImage;

    if (match!.player1!.id == user!.id!) {
      match!.player1!.character = character;
      await _firebaseService.setUserStatus(match!.player1!.id, 'waiting match');
    } else {
      match!.player2!.character = character;
      match!.status = 'in progress';
      await _firebaseService.setUserStatus(match!.player1!.id, 'playing');
      await _firebaseService.setUserStatus(match!.player2!.id, 'playing');
    }
    await _firebaseService.setMatch(match!);
  }

  static StreamSubscription<DatabaseEvent> listenUserChanged(
      void Function() onListenUserChanged) {
    return _firebaseService.listenUserChanged(user!.id!, (event) {
      final key = event.snapshot.key as String;

      if (key == 'status') {
        final status = event.snapshot.value as String;
        user!.status = status;

        if (status == 'online') {
          user!.match = null;
          match = null;
        }
      }

      onListenUserChanged();
    });
  }

  static StreamSubscription<DatabaseEvent> listenGameChanged(
      void Function(String key) onListenGameChanged) {
    return _firebaseService.listenGameChanged(match!.id!, (event) async {
      final key = event.snapshot.key as String;

      if (key == 'player_in_turn') {
        final playerInTurnJSON = event.snapshot.value as Map<Object?, dynamic>;
        final playerInTurn = PlayerModel.fromJSON(playerInTurnJSON);
        TicTacToeService.match!.playerInTurn = playerInTurn;
      }

      if (key == 'board') {
        final list = event.snapshot.value as List;
        match!.board = list.cast<String?>();
        grid = List.generate(
          match!.board!.length,
          (index) => SquareModel(
            index: index,
            backgroundColor: Colors.blueGrey,
            assetImage: match!.board![index]!,
          ),
        );
      }

      if (key == 'score') {
        final scoreJSON = event.snapshot.value as Map<Object?, dynamic>;
        final score = ScoreModel.fromJSON(scoreJSON);
        match!.score = score;
      }

      if (key == 'status') {
        final status = event.snapshot.value as String;
        match!.status = status;

        if (status == 'completed') {
          highlightWinningMove();
        }

        if (status == 'finished') {
          user!.status = 'online';
          _firebaseService.setUser(user!);
        }
      }

      if (key == 'player_2') {
        final player2JSON = event.snapshot.value as Map<Object?, dynamic>;
        final player2 = PlayerModel.fromJSON(player2JSON);
        match!.player2 = player2;
      }

      onListenGameChanged(key);
    });
  }

  static void highlightWinningMove() {
    final board = match!.board;
    Color backgroundColor = Color.fromARGB(255, 46, 110, 207);

    for (var i = 0; i <= 6; i += 3) {
      if (board![i] != openSpot &&
          board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2]) {
        grid![i].backgroundColor = backgroundColor;
        grid![i + 1].backgroundColor = backgroundColor;
        grid![i + 2].backgroundColor = backgroundColor;
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
        break;
      }
    }

    // Check for diagonal wins
    if (board![0] != openSpot && board[0] == board[4] && board[4] == board[8]) {
      grid![0].backgroundColor = backgroundColor;
      grid![4].backgroundColor = backgroundColor;
      grid![8].backgroundColor = backgroundColor;
    }

    if (board[2] != openSpot && board[2] == board[4] && board[4] == board[6]) {
      grid![2].backgroundColor = backgroundColor;
      grid![4].backgroundColor = backgroundColor;
      grid![6].backgroundColor = backgroundColor;
    }
  }

  static void resolveMove(int index) {
    // if (user!.id == playerInTurn.id) {
    if (match!.status != 'completed' && match!.board![index] == openSpot) {
      final playerInTurn = match!.playerInTurn;
      final player1IsPlayerInTurn = playerInTurn!.id == match!.player1!.id;

      match!.board![index] = playerInTurn.character!;
      bool matchHasWinner = checkForWinner();

      if (matchHasWinner || !(match!.board!.contains(openSpot))) {
        match!.status = 'completed';

        if (matchHasWinner) {
          player1IsPlayerInTurn
              ? match!.score!.wonMatchesPlayer1++
              : match!.score!.wonMatchesPlayer2++;
        } else {
          match!.score!.drawnMatches++;
        }
      } else {
        match!.playerInTurn =
            player1IsPlayerInTurn ? match!.player2 : match!.player1;
      }
    }
    // }

    _firebaseService.setMatch(match!);
  }

  static bool checkForWinner() {
    // Check horizontal wins
    final board = match!.board;
    bool hasWinner = false;

    for (var i = 0; i <= 6; i += 3) {
      if (board![i] != openSpot &&
          board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2]) {
        hasWinner = true;
        break;
      }
    }

    // Check vertical wins
    for (var i = 0; i <= 2; i++) {
      if (board![i] != openSpot &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        hasWinner = true;
        break;
      }
    }

    // Check for diagonal wins
    if ((board![0] != openSpot &&
            board[0] == board[4] &&
            board[4] == board[8]) ||
        (board[2] != openSpot &&
            board[2] == board[4] &&
            board[4] == board[6])) {
      hasWinner = true;
    }

    return hasWinner;
  }

  static Future<void> finishMatchAsync() async {
    match!.status = 'finished';
    _firebaseService.setMatch(match!);
    _firebaseService.removeMatchAsync(match!.id!);
  }
}
