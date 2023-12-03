import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/character.dart';
import 'package:tic_tac_toe/models/match.dart';
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

  static void setCharacterPlayer(int characterId) async {
    String assetPlayer1 = characters.elementAt(characterId).assetImage;

    var remainingCharacters = characters
        .where((element) => element.id != characterId)
        .toList(growable: false);

    var random = Random();
    String assetPlayer2 = remainingCharacters
        .elementAt(random.nextInt(remainingCharacters.length))
        .assetImage;

    match!.player1!.character = assetPlayer1;
    match!.player2!.character = assetPlayer2;
  }
}
