import 'package:flutter/material.dart';
import 'package:reto_3/widgets/tic_tac_toe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const TicTacToe();
  }
}
