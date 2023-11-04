import 'dart:async';

import 'package:bahn_bingo/domain/entity/game/game.dart';
import 'package:bahn_bingo/domain/usecase/game/toggle_event_usecase.dart';

abstract class GameRepository {
  Future<Game?> createGame(List<String> events);

  Future<Game?> joinGame(String gameId);

  Future<Game?> loadActiveGame();

  Future<bool> removeGameId();

  Future<Game?> toggleEvent(ToggleEventRequest index);

  Future<bool> isGameFinished(String gameId);

  Future<bool> callBingo(String gameId);
}
