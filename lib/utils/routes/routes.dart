import 'package:boilerplate/presentation/create_game/create_game.dart';
import 'package:boilerplate/presentation/game_field/game_field.dart';
import 'package:boilerplate/presentation/join_game/join_game.dart';
import 'package:boilerplate/presentation/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/game';
  static const String welcome = '/welcome';
  static const String joinGame = '/join';
  static const String createGame = '/create';

  static final routes = <String, WidgetBuilder>{
    joinGame: (BuildContext context) => LoginGameScreen(),
    home: (BuildContext context) => GameFieldScreen(),
    createGame: (BuildContext context) => CreateGameScreen(),
    welcome: (BuildContext context) => WelcomeScreen()
  };
}
