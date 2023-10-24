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
  Future<Game?> createGame(List<String> events) async {
    String gameId = Random().nextInt(10000).toString();
    Game? game =
        await Future.delayed(Duration(seconds: 2), () => new Game(id: gameId));
    if (game != null) {
      _sharedPrefsHelper.saveGameId(game.id);
    }
    return game;
  }

  @override
  Future<Game?> joinGame(String gameId) async {
    Game? game =
        await Future.delayed(Duration(seconds: 2), () => new Game(id: gameId));
    if (game != null) {
      _sharedPrefsHelper.saveGameId(game.id);
    }
    return game;
  }

  Future<Game?> loadActiveGame() {
    return _sharedPrefsHelper.gameId
        .then((value) => value != null ? new Game(id: value) : null);
  }

  @override
  Future<bool> saveGameId(String gameId) =>
      _sharedPrefsHelper.saveGameId(gameId);

  @override
  Future<bool> removeGameId() => _sharedPrefsHelper.removeGameId();

  @override
  Future<String?> get gameId => _sharedPrefsHelper.gameId;
}
