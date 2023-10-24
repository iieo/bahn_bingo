// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameStore on _GameStore, Store {
  late final _$gameAtom = Atom(name: '_GameStore.game', context: context);

  @override
  Game? get game {
    _$gameAtom.reportRead();
    return super.game;
  }

  @override
  set game(Game? value) {
    _$gameAtom.reportWrite(value, super.game, () {
      super.game = value;
    });
  }

  late final _$successAtom = Atom(name: '_GameStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_GameStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$joinGameAsyncAction =
      AsyncAction('_GameStore.joinGame', context: context);

  @override
  Future<void> joinGame(String gameId) {
    return _$joinGameAsyncAction.run(() => super.joinGame(gameId));
  }

  late final _$createGameAsyncAction =
      AsyncAction('_GameStore.createGame', context: context);

  @override
  Future<void> createGame(List<String> events) {
    return _$createGameAsyncAction.run(() => super.createGame(events));
  }

  late final _$_GameStoreActionController =
      ActionController(name: '_GameStore', context: context);

  @override
  void setGame(Game game) {
    final _$actionInfo =
        _$_GameStoreActionController.startAction(name: '_GameStore.setGame');
    try {
      return super.setGame(game);
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
game: ${game},
success: ${success},
isLoading: ${isLoading}
    ''';
  }
}
