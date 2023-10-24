import 'package:mobx/mobx.dart';

part 'game_error_store.g.dart';

class GameErrorStore = _GameErrorStore with _$GameErrorStore;

abstract class _GameErrorStore with Store {
  @observable
  String? gameError;
}
