import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/game_error_store.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/exit_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/get_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/load_game_usecase.dart';
import 'package:mobx/mobx.dart';
part 'game_store.g.dart';

class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  _GameStore(
      this._getGameUseCase,
      this._joinGameUseCase,
      this._createGameUseCase,
      this._loadGameUseCase,
      this._exitGameUseCase,
      this.gameErrorStore,
      this.errorStore) {
    _setupDisposers();
    _loadActiveGame();
  }

  Future<void> callBingo() async {}

  void exitGame() {
    game = null;
    _exitGameUseCase.call(params: null);
  }

  Future<void> _loadActiveGame() async {
    if (game != null) {
      return;
    }
    try {
      isLoading = true;
      game = await _loadGameUseCase.call(params: null);
      success = game != null;
    } catch (e) {
      errorStore.errorMessage = "error_load_game";
    } finally {
      isLoading = false;
    }
  }

  // use cases:-----------------------------------------------------------------
  final CreateGameUseCase _createGameUseCase;
  final JoinGameUseCase _joinGameUseCase;
  final ExitGameUseCase _exitGameUseCase;
  final GetGameUseCase _getGameUseCase;
  final LoadGameUseCase _loadGameUseCase;

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
