class ScoreModel {
  late int drawnMatches;
  late int wonMatchesPlayer1;
  late int wonMatchesPlayer2;

  ScoreModel({
    required this.drawnMatches,
    required this.wonMatchesPlayer1,
    required this.wonMatchesPlayer2,
  });

  ScoreModel.fromJSON(Map<Object?, dynamic> json) {
    drawnMatches = json['drawn_matches'];
    wonMatchesPlayer1 = json['won_matches_player_1'];
    wonMatchesPlayer2 = json['won_matches_player_2'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'drawn_matches': drawnMatches,
      'won_matches_player_1': wonMatchesPlayer1,
      'won_matches_player_2': wonMatchesPlayer2,
    };
  }
}
