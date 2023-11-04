import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/core/stores/theme/theme_store.dart';
import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class GameFieldActionMenu extends StatelessWidget {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final GameStore _gameStore = getIt<GameStore>();
  GameFieldActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text(
              AppLocalizations.of(context).translate('exit_game'),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onTap: () async {
              _gameStore.exitGame();
              //nav to home
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.welcome, (Route<dynamic> route) => false);
            },
          ),
          PopupMenuItem(
            child: Text(
              AppLocalizations.of(context).translate('undo_bingo'),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onTap: () {
              _gameStore.callBingo();
            },
          ),
          PopupMenuItem(
            child: Text(
              AppLocalizations.of(context).translate('change_theme'),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onTap: () {
              _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
            },
          )
        ];
      },
      onSelected: (value) {
        // Handle submenu item selection here
      },
      icon: Icon(Icons.more_vert),
      color: Theme.of(context).colorScheme.onPrimary,
    );
  }
}
