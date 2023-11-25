class StatisticsModel {
  late int wonMatches;
  late int lostMatches;
  late int tiedMatches;
  late int abandonedMatches;

  StatisticsModel({
    required this.wonMatches,
    required this.lostMatches,
    required this.tiedMatches,
    required this.abandonedMatches,
  });

  StatisticsModel.fromJSON(Map<Object?, dynamic> json) {
    wonMatches = json['wonMatches'];
    lostMatches = json['lostMatches'];
    tiedMatches = json['tiedMatches'];
    abandonedMatches = json['abandonedMatches'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'wonMatches': wonMatches,
      'lostMatches': lostMatches,
      'tiedMatches': tiedMatches,
      'abandonedMatches': abandonedMatches,
    };
  }
}
