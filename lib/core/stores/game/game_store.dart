import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'game_store.g.dart';

class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  final GameErrorStore gameErrorStore;
  // store for handling error messages
  final ErrorStore errorStore;

  _GameStore(this.gameErrorStore, this.errorStore) {
    _setupValidations();
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

  @observable
  bool success = false;

  @observable
  bool isLoading = false;

  // actions:-------------------------------------------------------------------
  @action
  void setGameId(String value) {
    gameId = value;
  }

  @action
  void validateGameId(String value) {
    if (value.isEmpty) {
      gameErrorStore.gameIdError = "error_gameid_empty";
    } else if (!isEmail(value)) {
      gameErrorStore.gameIdError = 'error_gameid_length';
    } else {
      gameErrorStore.gameIdError = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class GameErrorStore = _GameErrorStore with _$GameErrorStore;

abstract class _GameErrorStore with Store {
  @observable
  String? gameIdError;
}
