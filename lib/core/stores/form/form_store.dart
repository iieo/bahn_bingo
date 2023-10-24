import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // stores:--------------------------------------------------------------------
  final GameErrorStore gameErrorStore;
  // store for handling error messages
  final ErrorStore errorStore;

  _FormStore(this.gameErrorStore, this.errorStore) {
    _setupValidations();
    gameErrorStore.gameIdError = "error_gameid_empty";
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

  @computed
  bool get canJoin => gameErrorStore.gameIdError == null;

  // actions:-------------------------------------------------------------------
  @action
  void setGameId(String value) {
    gameId = value;
  }

  @action
  void validateGameId(String value) {
    if (value.isEmpty) {
      gameErrorStore.gameIdError = "error_gameid_empty";
    } else if (value.length != 4) {
      gameErrorStore.gameIdError = "error_gameid_length";
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

  void validateAll() {
    validateGameId(gameId);
  }
}

class GameErrorStore = _GameErrorStore with _$GameErrorStore;

abstract class _GameErrorStore with Store {
  @observable
  String? gameIdError;
}
