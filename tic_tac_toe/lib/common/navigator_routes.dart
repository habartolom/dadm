import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/available_games.dart';
import 'package:tic_tac_toe/screens/choose_character.dart';
import 'package:tic_tac_toe/screens/game.dart';
import 'package:tic_tac_toe/screens/home.dart';
import 'package:tic_tac_toe/screens/waiting_match.dart';
import 'package:tic_tac_toe/screens/waiting_rematch.dart';
import 'package:tic_tac_toe/screens/winner.dart';

class NavigatorRoutes {
  static const String homeRoute = '/';
  static const String boardRoute = '/board';
  static const String chooseCharacterRoute = '/chooseCharacter';
  static const String waitingMatchRoute = '/waitingMatch';
  static const String waitingReMatchRoute = '/waitingReMatch';
  static const String winnerRoute = '/winner';
  static const String availableGamesRoute = '/availableGames';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case chooseCharacterRoute:
        return MaterialPageRoute(builder: (_) => const ChooseCharacterScreen());
      case boardRoute:
        return MaterialPageRoute(builder: (_) => const GameScreen());
      case waitingMatchRoute:
        return MaterialPageRoute(builder: (_) => const WaitingMatchScreen());
      case waitingReMatchRoute:
        return MaterialPageRoute(builder: (_) => const WaitingReMatchScreen());
      case winnerRoute:
        return MaterialPageRoute(builder: (_) => const WinnerScreen());
      case availableGamesRoute:
        return MaterialPageRoute(builder: (_) => const AvailableGamesScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, homeRoute);
  }

  static void navigateToChooseCharacter(BuildContext context) {
    Navigator.pushNamed(context, chooseCharacterRoute);
  }

  static void navigateToBoard(BuildContext context) {
    Navigator.pushNamed(context, boardRoute);
  }

  static void navigateToWaitingMatch(BuildContext context) {
    Navigator.pushNamed(context, waitingMatchRoute);
  }

  static void navigateToWaitingReMatch(BuildContext context) {
    Navigator.pushNamed(context, waitingReMatchRoute);
  }

  static void navigateToWinner(BuildContext context) {
    Navigator.pushNamed(context, winnerRoute);
  }

  static void navigateToAvailableMatches(BuildContext context) {
    Navigator.pushNamed(context, availableGamesRoute);
  }

  static void navigateToChoosingAvatar(BuildContext context) {}
}
