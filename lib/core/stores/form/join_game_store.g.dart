// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$JoinGameStore on _JoinGameStore, Store {
  Computed<bool>? _$canJoinComputed;

  @override
  bool get canJoin => (_$canJoinComputed ??=
          Computed<bool>(() => super.canJoin, name: '_JoinGameStore.canJoin'))
      .value;

  late final _$gameIdAtom =
      Atom(name: '_JoinGameStore.gameId', context: context);

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

  late final _$_JoinGameStoreActionController =
      ActionController(name: '_JoinGameStore', context: context);

  @override
  void setGameId(String value) {
    final _$actionInfo = _$_JoinGameStoreActionController.startAction(
        name: '_JoinGameStore.setGameId');
    try {
      return super.setGameId(value);
    } finally {
      _$_JoinGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGameId(String value) {
    final _$actionInfo = _$_JoinGameStoreActionController.startAction(
        name: '_JoinGameStore.validateGameId');
    try {
      return super.validateGameId(value);
    } finally {
      _$_JoinGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gameId: ${gameId},
canJoin: ${canJoin}
    ''';
  }
}
