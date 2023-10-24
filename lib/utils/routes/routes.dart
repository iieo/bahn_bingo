import 'package:boilerplate/presentation/game_field/game_field.dart';
import 'package:boilerplate/presentation/login_game/login_game.dart';
import 'package:boilerplate/presentation/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/game';
  static const String welcome = '/welcome';
  static const String joinGame = '/join';

  static final routes = <String, WidgetBuilder>{
    joinGame: (BuildContext context) => LoginGameScreen(),
    home: (BuildContext context) => GameFieldScreen(),
    welcome: (BuildContext context) => WelcomeScreen()
  };
}
