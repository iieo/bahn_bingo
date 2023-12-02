import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GameFieldActionMenu extends StatelessWidget {
  final GameStore _gameStore = getIt<GameStore>();
  GameFieldActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).colorScheme.surface,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: AppLocalizations.of(context).translate('share_game'),
            textStyle: Theme.of(context).textTheme.labelMedium?.apply(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            child: Text(
              AppLocalizations.of(context).translate('share_game'),
              style: Theme.of(context).textTheme.labelMedium?.apply(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            onTap: () {
              Share.share(
                  AppLocalizations.of(context).translate('share_game_text') +
                      " ${_gameStore.game?.id ?? 'error'}");
            },
          ),
          PopupMenuItem(
            enabled: _gameStore.isGameFinished == true,
            textStyle: Theme.of(context).textTheme.labelMedium,
            child: Text(
              AppLocalizations.of(context).translate('undo_bingo'),
              style: Theme.of(context).textTheme.labelMedium?.apply(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            onTap: () {
              _gameStore.callBingo();
            },
          ),
          PopupMenuItem(
            textStyle: Theme.of(context).textTheme.labelMedium,
            child: Text(
              AppLocalizations.of(context).translate('exit_game'),
              style: Theme.of(context).textTheme.labelMedium?.apply(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            onTap: () async {
              _gameStore.exitGame();
              //nav to home
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.welcome, (Route<dynamic> route) => false);
            },
          ),
        ];
      },
      onSelected: (value) {
        // Handle submenu item selection here
      },
      icon:
          Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
