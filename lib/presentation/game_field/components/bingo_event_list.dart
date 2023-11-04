import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/core/widgets/button_widget.dart';
import 'package:bahn_bingo/presentation/game_field/components/event_list_item.dart';
import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/domain/entity/game/game.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class BingoEventList extends StatelessWidget {
  final GameStore _gameStore = getIt<GameStore>();
  BingoEventList({super.key});

  @override
  Widget build(BuildContext context) {
    List<EventItem> eventItems = _gameStore.game?.events ?? [];
    return SliverList.builder(
      itemCount: eventItems.length + 1,
      itemBuilder: (context, index) {
        if (index == eventItems.length) {
          if (_gameStore.isGameFinished) {
            return SizedBox.shrink();
          }
          return Container(
              margin:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: AppButton(
                text: AppLocalizations.of(context).translate('bingo'),
                type: ButtonType.PRIMARY,
                onPressed: _gameStore.callBingo,
              ));
        }
        return Observer(
            builder: (context) => EventListItem(
                  index: index,
                  done: eventItems[index].done,
                  task: eventItems[index].task,
                  onPressed: () {
                    _gameStore.toggleEvent(index);
                  },
                  isGameFinished: _gameStore.isGameFinished,
                ));
      },
    );
  }
}
