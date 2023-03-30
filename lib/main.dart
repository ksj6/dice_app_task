import 'package:flutter/material.dart';
import 'dice_screen.dart';
import 'initial_splash_screen.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        DiceScreen.id: (context) => DiceScreen(),
        SplashScreen.id: (context) => SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
    );
  }
}
