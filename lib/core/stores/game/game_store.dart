import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/game_error_store.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/usecase/game/call_bingo_usecase.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/exit_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/is_game_finished_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/load_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/toggle_event_usecase.dart';
import 'package:mobx/mobx.dart';
part 'game_store.g.dart';

class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  _GameStore(
      this._joinGameUseCase,
      this._createGameUseCase,
      this._loadGameUseCase,
      this._exitGameUseCase,
      this._toggleEventUseCase,
      this._callBingoUseCase,
      this._isGameFinishedUseCase,
      this.gameErrorStore,
      this.errorStore) {
    _setupDisposers();
    _loadActiveGame();
  }

  // use cases:-----------------------------------------------------------------
  final CreateGameUseCase _createGameUseCase;
  final JoinGameUseCase _joinGameUseCase;
  final ExitGameUseCase _exitGameUseCase;
  final LoadGameUseCase _loadGameUseCase;
  final ToggleEventUseCase _toggleEventUseCase;
  final CallBingoUseCase _callBingoUseCase;
  final IsGameFinishedUseCase _isGameFinishedUseCase;

  // stores:--------------------------------------------------------------------
  final GameErrorStore gameErrorStore;
  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  // store variables:-----------------------------------------------------------
  @observable
  Game? game = null;

  @observable
  bool isGameFinished = false;

  @observable
  bool success = false;

  @observable
  bool isLoading = false;

  // actions:-------------------------------------------------------------------
  @action
  void setGame(Game game) {
    game = game;
  }

  @action
  Future<void> joinGame(String gameId) async {
    try {
      isLoading = true;
      game = await _joinGameUseCase.call(params: gameId);
      success = game != null;
    } catch (e) {
      errorStore.errorMessage = "error_join_game";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createGame(List<String> events) async {
    try {
      isLoading = true;
      game = await _createGameUseCase.call(params: events);
      success = game != null;
    } catch (e) {
      errorStore.errorMessage = "error_create_game";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> callBingo() async {
    if (game == null) {
      return;
    }
    if (!game!.canCallBingo) {
      errorStore.errorMessage = "error_call_bingo_no_bingo";
      return;
    }
    try {
      isLoading = true;
      isGameFinished = await _callBingoUseCase.call(params: game!.id);
    } catch (e) {
      errorStore.errorMessage = "error_call_bingo";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleEvent(int index) async {
    try {
      isLoading = true;
      game = await _toggleEventUseCase.call(
          params: ToggleEventRequest(game!, index));
      success = game != null;
    } catch (e) {
      errorStore.errorMessage = "error_toggle_event";
    } finally {
      isLoading = false;
    }
  }

  @action
  void exitGame() {
    game = null;
    _exitGameUseCase.call(params: null);
  }

  // reactions:-----------------------------------------------------------------
  Future<void> _loadActiveGame() async {
    if (game != null) {
      return;
    }
    try {
      isLoading = true;
      game = await _loadGameUseCase.call(params: null);
      isGameFinished = await _isGameFinishedUseCase.call(params: game!.id);
      success = game != null;
    } catch (e) {
      errorStore.errorMessage = "error_load_game";
    } finally {
      isLoading = false;
    }
  }

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
