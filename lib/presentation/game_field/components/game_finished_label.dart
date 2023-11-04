import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GameFinishedLabel extends StatelessWidget {
  final GameStore _gameStore = getIt<GameStore>();
  GameFinishedLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_gameStore.isGameFinished) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          height: 50,
          child: Center(
            child: Text(AppLocalizations.of(context).translate('game_finished'),
                style: Theme.of(context).textTheme.labelLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeightDelta: 2)),
          ),
        );
      }
      return SizedBox.shrink();
    });
  }
}
