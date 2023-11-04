// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateGameStore on _CreateGameStore, Store {
  Computed<bool>? _$canAddEventComputed;

  @override
  bool get canAddEvent =>
      (_$canAddEventComputed ??= Computed<bool>(() => super.canAddEvent,
              name: '_CreateGameStore.canAddEvent'))
          .value;
  Computed<bool>? _$canCreateGameComputed;

  @override
  bool get canCreateGame =>
      (_$canCreateGameComputed ??= Computed<bool>(() => super.canCreateGame,
              name: '_CreateGameStore.canCreateGame'))
          .value;

  late final _$eventsAtom =
      Atom(name: '_CreateGameStore.events', context: context);

  @override
  ObservableList<String> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<String> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$fieldSizeAtom =
      Atom(name: '_CreateGameStore.fieldSize', context: context);

  @override
  int get fieldSize {
    _$fieldSizeAtom.reportRead();
    return super.fieldSize;
  }

  @override
  set fieldSize(int value) {
    _$fieldSizeAtom.reportWrite(value, super.fieldSize, () {
      super.fieldSize = value;
    });
  }

  late final _$currentEventAtom =
      Atom(name: '_CreateGameStore.currentEvent', context: context);

  @override
  String get currentEvent {
    _$currentEventAtom.reportRead();
    return super.currentEvent;
  }

  @override
  set currentEvent(String value) {
    _$currentEventAtom.reportWrite(value, super.currentEvent, () {
      super.currentEvent = value;
    });
  }

  late final _$inventEventAsyncAction =
      AsyncAction('_CreateGameStore.inventEvent', context: context);

  @override
  Future<void> inventEvent() {
    return _$inventEventAsyncAction.run(() => super.inventEvent());
  }

  late final _$_CreateGameStoreActionController =
      ActionController(name: '_CreateGameStore', context: context);

  @override
  void setCurrentEvent(String value) {
    final _$actionInfo = _$_CreateGameStoreActionController.startAction(
        name: '_CreateGameStore.setCurrentEvent');
    try {
      return super.setCurrentEvent(value);
    } finally {
      _$_CreateGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addEvent(String value) {
    final _$actionInfo = _$_CreateGameStoreActionController.startAction(
        name: '_CreateGameStore.addEvent');
    try {
      return super.addEvent(value);
    } finally {
      _$_CreateGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeEvent(int index) {
    final _$actionInfo = _$_CreateGameStoreActionController.startAction(
        name: '_CreateGameStore.removeEvent');
    try {
      return super.removeEvent(index);
    } finally {
      _$_CreateGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFieldSize(int value) {
    final _$actionInfo = _$_CreateGameStoreActionController.startAction(
        name: '_CreateGameStore.setFieldSize');
    try {
      return super.setFieldSize(value);
    } finally {
      _$_CreateGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCurrentEvent(String event) {
    final _$actionInfo = _$_CreateGameStoreActionController.startAction(
        name: '_CreateGameStore.validateCurrentEvent');
    try {
      return super.validateCurrentEvent(event);
    } finally {
      _$_CreateGameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
events: ${events},
fieldSize: ${fieldSize},
currentEvent: ${currentEvent},
canAddEvent: ${canAddEvent},
canCreateGame: ${canCreateGame}
    ''';
  }
}
