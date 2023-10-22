import 'dart:async';
import 'dart:math';

import 'package:boilerplate/domain/repository/game/game_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

class GameRepositoryImpl extends GameRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  GameRepositoryImpl(this._sharedPrefsHelper);

  // Game:---------------------------------------------------------------------

  @override
  Future<String> createGame(LoginParams params) async {
    String gameId = Random().nextInt(10000).toString();
    return await Future.delayed(Duration(seconds: 2), () => gameId);
  }

  @override
  Future<void> joinGame(String gameId) async {
    return await Future.delayed(Duration(seconds: 2), () => null);
  }

  @override
  Future<bool> saveGameId(String gameId) =>
      _sharedPrefsHelper.saveGameId(gameId);

  @override
  Future<bool> removeGameId() => _sharedPrefsHelper.removeGameId();

  @override
  Future<String?> get gameId => _sharedPrefsHelper.gameId;
}
