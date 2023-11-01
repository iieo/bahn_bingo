import 'dart:async';

import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/usecase/game/toggle_event_usecase.dart';

abstract class GameRepository {
  Future<Game?> createGame(List<String> events);

  Future<Game?> joinGame(String gameId);

  Future<Game?> loadActiveGame();

  Future<bool> removeGameId();

  Future<Game?> toggleEvent(ToggleEventRequest index);

  Future<bool> isGameFinished(String gameId);

  Future<bool> callBingo(String gameId);
}
