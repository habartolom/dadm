import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:tic_tac_toe/models/match.dart';
import 'package:tic_tac_toe/models/user.dart';
import 'package:tic_tac_toe/services/tictactoe_service.dart';

class FirebaseService {
  final _users = FirebaseDatabase.instance.ref("users");
  final _games = FirebaseDatabase.instance.ref("games");

  StreamSubscription<DatabaseEvent> listenUserChanged(
      String userId, void Function(DatabaseEvent event) onData) {
    final statusNodeRef = _users.child(userId);
    return statusNodeRef.onChildChanged.listen(onData);
  }

  Future<void> registerUser(UserModel user) async {
    final DatabaseReference userNodeRef = _users.push();
    user.id = userNodeRef.key!;
    final userJSON = user.toJSON();
    await userNodeRef.set(userJSON);
  }

  Future<void> startNewGame(MatchModel match) async {
    final DatabaseReference gameNodeRef = _games.push();
    match.id = gameNodeRef.key!;
    final gameJSON = match.toJSON();
    await gameNodeRef.set(gameJSON);
  }

  Future<void> setUser(UserModel user) async {
    final userNodeRef = _users.child("/${user.id}");
    final userJSON = user.toJSON();
    await userNodeRef.set(userJSON);
  }

  Future<UserModel?> getUser(String userId) async {
    UserModel? user;

    try {
      final userNodeRef = _users.child(userId);
      final snapshot = await userNodeRef.get();
      final userJSON = snapshot.value as Map<Object?, dynamic>;
      user = UserModel.fromJSON(userId, userJSON);
    } catch (error) {
      print("Error al obtener el jugador: $error");
    }

    return user;
  }

  Future<int> getMathesCount() async {
    int matchesCount = 0;

    try {
      final matchesCountNodeRef = _games.child('count');
      final snapshot = await matchesCountNodeRef.get();
      matchesCount = snapshot.value as int;
    } catch (error) {
      print("Error al obtener el número de encuentros: $error");
    }

    return matchesCount;
  }

  Future<void> setMatchesCount(int count) async {
    await _games.update({'count': count});
  }

  Future<MatchModel?> getMatchByIdAsync(String matchId) async {
    MatchModel? game;

    try {
      final matchNodeRef = _games.child(matchId);
      final snapshot = await matchNodeRef.get();
      final matchJSON = snapshot.value as Map<Object?, dynamic>;
      game = MatchModel.fromJSON(matchId, matchJSON);
    } catch (error) {
      print("Error al obtener el encuentro: $error");
    }

    return game;
  }

  Future<void> setMatch(MatchModel match) async {
    final matchNodeRef = _games.child("/${match.id}");
    final matchJSON = match.toJSON();
    await matchNodeRef.set(matchJSON);
  }

  Future<void> setUserListener(String userId) async {
    final userNodeRef = _users.child(userId);
    userNodeRef.onValue.listen((DatabaseEvent event) {
      final userJSON = event.snapshot.value as Map<Object?, dynamic>;
      final user = UserModel.fromJSON(userId, userJSON);
      TicTacToeService.user = user;
      print("user data: $user");
    });
  }

  Future<void> setCharacterPlayer(
      int player, String matchId, int characterId) async {
    final userNodeRef = _games.child('$matchId/player_$player');
    await userNodeRef.update({'character': characterId});
  }

  Future<void> setUserStatus(String userId, String status) async {
    final userNodeRef = _users.child(userId);
    await userNodeRef.update({'status': status});
  }
}
