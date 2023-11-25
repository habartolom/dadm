class PlayerModel {
  late String id;
  int? character;

  PlayerModel({
    required this.id,
    this.character,
  });

  PlayerModel.fromJSON(Map<Object?, dynamic> json) {
    id = json['id'];
    character = json['character'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'character': character,
    };
  }
}
