// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormStore on _JoinGameStore, Store {
  Computed<bool>? _$canJoinComputed;

  @override
  bool get canJoin => (_$canJoinComputed ??=
          Computed<bool>(() => super.canJoin, name: '_FormStore.canJoin'))
      .value;

  late final _$gameIdAtom = Atom(name: '_FormStore.gameId', context: context);

  @override
  String get gameId {
    _$gameIdAtom.reportRead();
    return super.gameId;
  }

  @override
  set gameId(String value) {
    _$gameIdAtom.reportWrite(value, super.gameId, () {
      super.gameId = value;
    });
  }

  late final _$successAtom = Atom(name: '_FormStore.success', context: context);

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

  late final _$_FormStoreActionController =
      ActionController(name: '_FormStore', context: context);

  @override
  void setGameId(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setGameId');
    try {
      return super.setGameId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGameId(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateGameId');
    try {
      return super.validateGameId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gameId: ${gameId},
success: ${success},
canJoin: ${canJoin}
    ''';
  }
}

mixin _$GameErrorStore on _GameErrorStore, Store {
  late final _$gameIdErrorAtom =
      Atom(name: '_GameErrorStore.gameIdError', context: context);

  @override
  String? get gameIdError {
    _$gameIdErrorAtom.reportRead();
    return super.gameIdError;
  }

  @override
  set gameIdError(String? value) {
    _$gameIdErrorAtom.reportWrite(value, super.gameIdError, () {
      super.gameIdError = value;
    });
  }

  @override
  String toString() {
    return '''
gameIdError: ${gameIdError}
    ''';
  }
}
