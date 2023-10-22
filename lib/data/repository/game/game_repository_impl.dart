import 'dart:async';
import 'dart:math';

import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/repository/game/game_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';

class GameRepositoryImpl extends GameRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  GameRepositoryImpl(this._sharedPrefsHelper);

  // Game:---------------------------------------------------------------------

  @override
  Future<Game?> createGame() async {
    String gameId = Random().nextInt(10000).toString();
    return await Future.delayed(
        Duration(seconds: 2), () => new Game(id: gameId));
  }

  @override
  Future<Game?> joinGame(String gameId) async {
    return await Future.delayed(
        Duration(seconds: 2), () => new Game(id: gameId));
  }

  @override
  Future<bool> saveGameId(String gameId) =>
      _sharedPrefsHelper.saveGameId(gameId);

  @override
  Future<bool> removeGameId() => _sharedPrefsHelper.removeGameId();

  @override
  Future<String?> get gameId => _sharedPrefsHelper.gameId;
}
