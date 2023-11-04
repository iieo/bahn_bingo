import 'package:bahn_bingo/core/stores/error/error_store.dart';
import 'package:bahn_bingo/core/stores/form/game_error_store.dart';
import 'package:mobx/mobx.dart';

part 'join_game_store.g.dart';

class JoinGameStore = _JoinGameStore with _$JoinGameStore;

abstract class _JoinGameStore with Store {
  // stores:--------------------------------------------------------------------
  final GameErrorStore gameErrorStore;
  // store for handling error messages
  final ErrorStore errorStore;

  _JoinGameStore(this.gameErrorStore, this.errorStore) {
    _setupValidations();
    gameErrorStore.gameError = "error_gameid_empty";
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => gameId, validateGameId),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String gameId = '';

  @computed
  bool get canJoin => gameErrorStore.gameError == null;

  // actions:-------------------------------------------------------------------
  @action
  void setGameId(String value) {
    gameId = value;
  }

  @action
  void validateGameId(String value) {
    if (value.isEmpty) {
      gameErrorStore.gameError = "error_gameid_empty";
    } else if (value.length != 4) {
      gameErrorStore.gameError = "error_gameid_length";
    } else {
      gameErrorStore.gameError = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateGameId(gameId);
  }
}
