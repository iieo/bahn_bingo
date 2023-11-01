import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game extends _Game with _$Game {
  Game(
      {required String id,
      int fieldSize = 3,
      List<EventItem> events = const []})
      : super(id: id, fieldSize: fieldSize, events: events);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

abstract class _Game with Store {
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;

  int fieldSize;

  _Game({required this.id, this.fieldSize = 3, this.events = const []});

  // @observable
  @observable
  List<EventItem> events;

  // @action

  @action
  void toggleEvent(int index) {
    events[index].toggleDone();
  }

  @action
  void shuffleEvents() {
    events.shuffle();
  }

  // @computed

  @computed
  bool get canCallBingo {
    for (int i = 0; i < fieldSize; i++) {
      bool row = true;
      bool column = true;
      bool diagonal1 = true;
      bool diagonal2 = true;
      for (int j = 0; j < fieldSize; j++) {
        row &= events[i * fieldSize + j].done;
        column &= events[j * fieldSize + i].done;
        diagonal1 &= events[j * fieldSize + j].done;
        diagonal2 &= events[j * fieldSize + (fieldSize - j - 1)].done;
      }
      if (row || column || diagonal1 || diagonal2) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    return 'Game{id: $id, fieldSize: $fieldSize, events: $events}';
  }
}

@JsonSerializable()
class EventItem extends _EventItem with _$EventItem {
  EventItem({required String task, bool done = false})
      : super(task: task, done: done);

  factory EventItem.fromJson(Map<String, dynamic> json) =>
      _$EventItemFromJson(json);

  Map<String, dynamic> toJson() => _$EventItemToJson(this);
}

abstract class _EventItem with Store {
  final String task;

  _EventItem({required this.task, this.done = false});

  // @observable
  @observable
  bool done;

  // @action

  @action
  void toggleDone() {
    done = !done;
  }

  @override
  String toString() {
    return 'EventItem{task: $task, done: $done}';
  }
}
