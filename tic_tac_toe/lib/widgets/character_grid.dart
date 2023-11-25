import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/character.dart';
import 'package:tic_tac_toe/widgets/avatar.dart';

class CharacterGridWidget extends StatefulWidget {
  const CharacterGridWidget({
    super.key,
    required this.characters,
    required this.onCharacterTapped,
  });

  final List<CharacterModel> characters;
  final Function(int) onCharacterTapped;

  @override
  State<CharacterGridWidget> createState() => _AvatarGridWidgetState();
}

class _AvatarGridWidgetState extends State<CharacterGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: widget.characters.length,
      itemBuilder: (BuildContext context, int index) {
        return AvatarWidget(
          backgroundColor: widget.characters[index].backgroundColor,
          assetImage: widget.characters[index].assetImage,
          onTap: () => widget.onCharacterTapped(index),
        );
      },
    );
  }
}
