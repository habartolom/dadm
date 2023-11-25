import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/models/score.dart';

class MatchModel {
  late String? id;
  late int? number;
  late PlayerModel? player1;
  late PlayerModel? player2;
  late String? status;
  late ScoreModel? score;
  late List<String?>? board;

  MatchModel({
    this.id,
    this.number,
    this.player1,
    this.player2,
    this.status,
    this.score,
    this.board,
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
  }

  Map<String, dynamic> toJSON() {
    return {
      'number': number,
      'player_1': player1 != null ? player1!.toJSON() : null,
      'player_2': player2 != null ? player2!.toJSON() : null,
      'status': status,
      'score': score != null ? score!.toJSON() : null,
      'board': board,
    };
  }
}
