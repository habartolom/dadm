import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/models/character.dart';
import 'package:tic_tac_toe/models/match.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/models/score.dart';
import 'package:tic_tac_toe/models/statistics.dart';
import 'package:tic_tac_toe/models/user.dart';
import 'package:tic_tac_toe/services/firebase_service.dart';

class TicTacToeService {
  static FirebaseService firebaseService = FirebaseService();
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

  static Future<UserModel?> getUserPlayerAsync() async {
    String? userId = await getSavedUserIdAsync();

    if (userId == null) {
      user = UserModel(
        registrationDate: DateTime.now().toUtc(),
        status: 'online',
        statistics: StatisticsModel(
            wonMatches: 0, lostMatches: 0, tiedMatches: 0, abandonedMatches: 0),
      );
      await firebaseService.registerUser(user!);

      userId = user!.id!;
      await saveUserIdLocally(userId);
    }

    print('userId: $userId');
    user ??= await firebaseService.getUser(userId);
    return user;
  }

  static Future<void> getMatchAsync() async {
    if (user!.match != null) {
      match = await firebaseService.getMatchByIdAsync(user!.match!);
    }
  }

  static Future<void> startNewGame() async {
    int matchesCount = await firebaseService.getMathesCount();
    PlayerModel player = PlayerModel(id: user!.id!);
    match = MatchModel(
      number: ++matchesCount,
      player1: player,
      status: 'pending',
      score: ScoreModel(
        drawnMatches: 0,
        wonMatchesPlayer1: 0,
        wonMatchesPlayer2: 0,
      ),
    );
    await firebaseService.startNewGame(match!);
    user?.match = match!.id;
    user?.status = 'choosing avatar';
    await firebaseService.setUser(user!);
    await firebaseService.setMatchesCount(matchesCount);
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
    int playerId;

    if (match!.player1!.id == user!.id!) {
      match!.player1!.character = characterId;
      playerId = 1;
      await firebaseService.setUserStatus(match!.player1!.id, 'waiting match');
    } else {
      match!.player2!.character = characterId;
      playerId = 2;
      await firebaseService.setUserStatus(match!.player1!.id, 'playing');
      await firebaseService.setUserStatus(match!.player2!.id, 'playing');
    }
    await firebaseService.setCharacterPlayer(playerId, match!.id!, characterId);
  }

  static StreamSubscription<DatabaseEvent> listenUserChanged(
      void Function(DatabaseEvent event) onData) {
    return firebaseService.listenUserChanged(user!.id!, onData);
  }
}
