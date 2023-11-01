import 'dart:async';
import 'dart:math';

import 'package:boilerplate/data/network/firebase/firebase_game.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/repository/game/game_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/usecase/game/toggle_event_usecase.dart';
import 'package:boilerplate/utils/utils.dart';

class GameRepositoryImpl extends GameRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final FirebaseGame _firebaseGame;

  // constructor
  GameRepositoryImpl(this._sharedPrefsHelper, this._firebaseGame);

  // Game:---------------------------------------------------------------------

  @override
  Future<Game?> createGame(List<String> events) async {
    List<EventItem> eventItems = events.map((e) => EventItem(task: e)).toList();
    int fieldSize = sqrt(eventItems.length).ceil();
    Game game =
        Game(id: generateRandomId(), fieldSize: fieldSize, events: eventItems);
    print("Creating game with id: ${game.id}");
    if (!await _sharedPrefsHelper.saveGameId(game.id)) {
      return null;
    }
    await _firebaseGame.createGame(game);
    await _firebaseGame.saveGame(game);
    return game;
  }

  @override
  Future<Game?> joinGame(String gameId) async {
    print("Joining game: $gameId");
    Game? game = await _firebaseGame.getGame(gameId);
    if (game == null) {
      game = await _firebaseGame.joinGame(gameId);
      game?.shuffleEvents();
    }
    if (game != null && await _sharedPrefsHelper.saveGameId(game.id)) {
      await _firebaseGame.saveGame(game);
      return game;
    }
    return null;
  }

  @override
  Future<Game?> loadActiveGame() async {
    String? gameID = await _sharedPrefsHelper.gameId;
    print("Loading game with gameID: $gameID");
    if (gameID != null && gameID.isNotEmpty) {
      return await _firebaseGame.getGame(gameID);
    }
    return null;
  }

  @override
  Future<Game?> toggleEvent(ToggleEventRequest request) async {
    Game game = request.game;
    print("Toggling event with index: ${request.index}");
    game.toggleEvent(request.index);
    if (await _firebaseGame.saveGame(game)) {
      return game;
    } else {
      return null;
    }
  }

  @override
  Future<bool> isGameFinished(String gameId) async {
    return await _firebaseGame.isGameFinished(gameId);
  }

  @override
  Future<bool> callBingo(String gameId) async {
    bool isFinished = await _firebaseGame.isGameFinished(gameId);
    await _firebaseGame.callBingo(gameId, !isFinished);
    return !isFinished;
  }

  @override
  Future<bool> removeGameId() => _sharedPrefsHelper.removeGameId();
}
