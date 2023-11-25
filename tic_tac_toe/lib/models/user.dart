import 'package:tic_tac_toe/models/statistics.dart';

class UserModel {
  String? id;
  DateTime? registrationDate;
  String? status;
  StatisticsModel? statistics;
  String? match;

  UserModel({
    this.id,
    this.registrationDate,
    this.status,
    this.statistics,
    this.match,
  });

  UserModel.fromJSON(String this.id, Map<Object?, dynamic> json) {
    registrationDate = DateTime.parse(json['registration_date']);
    status = json['status'];
    statistics = json['statistics'] != null
        ? StatisticsModel.fromJSON(json['statistics'])
        : null;
    match = json['match'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'registration_date': registrationDate?.toIso8601String(),
      'status': status,
      'statistics': statistics != null ? statistics!.toJSON() : null,
      'match': match,
    };
  }
}
