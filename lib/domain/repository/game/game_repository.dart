import 'dart:async';

import 'package:boilerplate/domain/entity/game/game.dart';

abstract class GameRepository {
  Future<Game?> createGame(List<String> events);

  Future<Game?> joinGame(String gameId);

  Future<Game?> loadActiveGame();

  Future<String?> get gameId;

  Future<bool> saveGameId(String gameId);

  Future<bool> removeGameId();
}
