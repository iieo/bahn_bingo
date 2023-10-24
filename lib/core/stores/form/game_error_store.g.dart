// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameErrorStore on _GameErrorStore, Store {
  late final _$gameErrorAtom =
      Atom(name: '_GameErrorStore.gameError', context: context);

  @override
  String? get gameError {
    _$gameErrorAtom.reportRead();
    return super.gameError;
  }

  @override
  set gameError(String? value) {
    _$gameErrorAtom.reportWrite(value, super.gameError, () {
      super.gameError = value;
    });
  }

  @override
  String toString() {
    return '''
gameError: ${gameError}
    ''';
  }
}
