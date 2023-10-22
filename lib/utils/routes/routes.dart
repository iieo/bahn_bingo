import 'package:boilerplate/presentation/create_game/create_game.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';
  static const String welcome = '/welcome';
  static const String joinGame = '/join';
  static const String createGame = '/create';

  static final routes = <String, WidgetBuilder>{
    joinGame: (BuildContext context) => CreateGameScreen(),
    createGame: (BuildContext context) => CreateGameScreen(),
    home: (BuildContext context) => HomeScreen(),
    welcome: (BuildContext context) => WelcomeScreen()
  };
}
