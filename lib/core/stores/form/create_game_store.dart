import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/game_error_store.dart';
import 'package:mobx/mobx.dart';

part 'create_game_store.g.dart';

class CreateGameStore = _CreateGameStore with _$CreateGameStore;

abstract class _CreateGameStore with Store {
  // stores:--------------------------------------------------------------------
  final GameErrorStore gameErrorStore;
  // store for handling error messages
  final ErrorStore errorStore;

  _CreateGameStore(this.gameErrorStore, this.errorStore) {
    _setupValidations();
    gameErrorStore.gameError = "error_gameid_empty";
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => currentEvent, validateCurrentEvent),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  List<String> events = [];

  @observable
  String currentEvent = "";

  @computed
  bool get canCreateGame => gameErrorStore.gameError == null;

  // actions:-------------------------------------------------------------------

  @action
  void setCurrentEvent(String value) {
    currentEvent = value;
  }

  @action
  void addEvent(String value) {
    events.add(value);
  }

  @action
  void removeEvent(int index) {
    events.removeAt(index);
  }

  @action
  void validateCurrentEvent(String event) {
    if (event.isEmpty) {
      gameErrorStore.gameError = "error_game_event_empty";
    } else if (event.length < 5) {
      gameErrorStore.gameError = "error_game_event_length";
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
    validateCurrentEvent(currentEvent);
  }
}
