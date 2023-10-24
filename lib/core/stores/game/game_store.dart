import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/get_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:mobx/mobx.dart';
part 'game_store.g.dart';

class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  _GameStore(this._getGameUseCase, this._joinGameUseCase,
      this._createGameUseCase, this.gameErrorStore, this.errorStore) {
    _setupDisposers();
  }

  // use cases:-----------------------------------------------------------------
  final CreateGameUseCase _createGameUseCase;
  final JoinGameUseCase _joinGameUseCase;
  final GetGameUseCase _getGameUseCase;

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
      success = await _joinGameUseCase.call(params: gameId) != null;
    } catch (e) {
      errorStore.errorMessage = "error_join_game";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createGame() async {
    try {
      isLoading = true;
      success = await _createGameUseCase.call(params: null) != null;
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
