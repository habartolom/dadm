import 'package:tic_tac_toe/enums/game_difficulty_level.dart';
import 'package:tic_tac_toe/enums/game_status.dart';
import 'package:tic_tac_toe/enums/game_winner.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/models/score.dart';

class MatchModel {
  late String? id;
  late int? number;
  late PlayerModel? player1;
  late PlayerModel? player2;
  late GameStatusEnum? status;
  late ScoreModel? score;
  late List<String?>? board;
  late PlayerModel? currentPlayer;
  late PlayerModel? initialPlayer;
  late GameWinnerEnum? winner;
  late GameDifficultyLevelEnum? difficultyLevel;

  MatchModel({
    this.id,
    this.number,
    this.player1,
    this.player2,
    this.status,
    this.score,
    this.board,
    this.currentPlayer,
    this.initialPlayer,
    this.winner,
    this.difficultyLevel,
  });

  MatchModel.fromJSON(this.id, Map<Object?, dynamic> json) {
    number = json['number'];
    player1 = (json['player_1'] != null
        ? PlayerModel.fromJSON(json['player_1'])
        : null)!;
    player2 = json['player_2'] != null
        ? PlayerModel.fromJSON(json['player_2'])
        : null;
    status = json['status'];
    score = json['score'] != null ? ScoreModel.fromJSON(json['score']) : null;
    board = json['board'] != null ? List<String?>.from(json['board']) : null;
    currentPlayer = json['player_in_turn'] != null
        ? PlayerModel.fromJSON(json['player_in_turn'])
        : null;
  }

  Map<String, dynamic> toJSON() {
    return {
      'number': number,
      'player_1': player1?.toJSON(),
      'player_2': player2?.toJSON(),
      'status': status,
      'score': score?.toJSON(),
      'board': board,
      'player_in_turn': currentPlayer?.toJSON(),
    };
  }
}
