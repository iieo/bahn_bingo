import 'dart:async';

import 'package:boilerplate/domain/usecase/user/login_usecase.dart';

abstract class GameRepository {
  Future<String> createGame(LoginParams params);

  Future<void> joinGame(String gameId);

  Future<String?> get gameId;

  Future<bool> saveGameId(String gameId);

  Future<bool> removeGameId();
}
