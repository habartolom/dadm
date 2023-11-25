import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/common/navigator_routes.dart';
import 'package:tic_tac_toe/firebase_options.dart';
import 'package:tic_tac_toe/services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final multiProvider = MultiProvider(
    providers: [
      Provider<FirebaseService>.value(value: FirebaseService()),
    ],
    child: const MainApp(),
  );

  runApp(multiProvider);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      initialRoute: NavigatorRoutes.homeRoute,
      onGenerateRoute: NavigatorRoutes.generateRoute,
    );
  }
}
