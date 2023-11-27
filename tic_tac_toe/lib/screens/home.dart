import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/services/firebase_service.dart';
import 'package:tic_tac_toe/services/tictactoe_service.dart';
import 'package:tic_tac_toe/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseService firebaseService;

  void redirect(BuildContext context) async {
    final user = await TicTacToeService.getUserPlayerAsync();
    await TicTacToeService.getMatchAsync();
    if (user!.status == "online") {
      NavigatorRoutes.navigateToAvailableMatches(context);
    } else if (user!.status == 'choosing avatar') {
      NavigatorRoutes.navigateToChooseCharacter(context);
    } else if (user!.status == 'waiting match') {
      NavigatorRoutes.navigateToWaitingMatch(context);
    } else if (user!.status == 'playing') {
      NavigatorRoutes.navigateToBoard(context);
    } else if (user!.status == 'finishing') {
      NavigatorRoutes.navigateToWinner(context);
    } else if (user!.status == 'waiting rematch') {
      NavigatorRoutes.navigateToWaitingReMatch(context);
    } else {
      NavigatorRoutes.navigateToAvailableMatches(context);
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseService = context.read<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Come and play with the',
                style: TextStyle(
                  fontFamily: 'Gabriela',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'ANGRY BIRDS!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 35, 110, 240),
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                "assets/images/angry_birds_icon.png",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 10, 54, 90),
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: const Text(
                        "Play with Bot",
                        style: TextStyle(
                          fontFamily: 'Gabriela',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () => {
                        redirect(context),
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 10, 54, 90),
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: const Text(
                        "Play Online",
                        style: TextStyle(
                          fontFamily: 'Gabriela',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              label: 'Game',
            ),
          ],
        ),
      ),
    );
  }
}
