// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as String,
      fieldSize: json['fieldSize'] as int? ?? 3,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => EventItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'fieldSize': instance.fieldSize,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

EventItem _$EventItemFromJson(Map<String, dynamic> json) => EventItem(
      task: json['task'] as String,
      done: json['done'] as bool? ?? false,
    );

Map<String, dynamic> _$EventItemToJson(EventItem instance) => <String, dynamic>{
      'task': instance.task,
      'done': instance.done,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Game on _Game, Store {
  Computed<bool>? _$canCallBingoComputed;

  @override
  bool get canCallBingo => (_$canCallBingoComputed ??=
          Computed<bool>(() => super.canCallBingo, name: '_Game.canCallBingo'))
      .value;

  late final _$eventsAtom = Atom(name: '_Game.events', context: context);

  @override
  List<EventItem> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(List<EventItem> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$_GameActionController =
      ActionController(name: '_Game', context: context);

  @override
  void toggleEvent(int index) {
    final _$actionInfo =
        _$_GameActionController.startAction(name: '_Game.toggleEvent');
    try {
      return super.toggleEvent(index);
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  void shuffleEvents() {
    final _$actionInfo =
        _$_GameActionController.startAction(name: '_Game.shuffleEvents');
    try {
      return super.shuffleEvents();
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
events: ${events},
canCallBingo: ${canCallBingo}
    ''';
  }
}

mixin _$EventItem on _EventItem, Store {
  late final _$doneAtom = Atom(name: '_EventItem.done', context: context);

  @override
  bool get done {
    _$doneAtom.reportRead();
    return super.done;
  }

  @override
  set done(bool value) {
    _$doneAtom.reportWrite(value, super.done, () {
      super.done = value;
    });
  }

  late final _$_EventItemActionController =
      ActionController(name: '_EventItem', context: context);

  @override
  void toggleDone() {
    final _$actionInfo =
        _$_EventItemActionController.startAction(name: '_EventItem.toggleDone');
    try {
      return super.toggleDone();
    } finally {
      _$_EventItemActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
done: ${done}
    ''';
  }
}
