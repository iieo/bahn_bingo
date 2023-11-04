import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/presentation/game_field/components/bingo_event_list.dart';
import 'package:bahn_bingo/presentation/game_field/components/bingo_grid.dart';
import 'package:bahn_bingo/presentation/game_field/components/game_field_action_menu.dart';
import 'package:bahn_bingo/presentation/game_field/components/game_finished_label.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/messages/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GameFieldScreen extends StatefulWidget {
  const GameFieldScreen({super.key});

  @override
  State<GameFieldScreen> createState() => _GameFieldScreenState();
}

class _GameFieldScreenState extends State<GameFieldScreen> {
  final GameStore _gameStore = getIt<GameStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('game_id_title') +
            " ${_gameStore.game?.id ?? 'error'}"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [GameFieldActionMenu()],
      ),
      body: Stack(children: [
        _gameStore.game == null
            ? Center(child: CircularProgressIndicator.adaptive())
            : Column(
                children: [
                  GameFinishedLabel(),
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
                      BingoGrid(),
                      SliverToBoxAdapter(
                        child: const SizedBox(height: 16.0),
                      ),
                      BingoEventList(),
                    ],
                  ))
                ],
              ),
        Observer(
          builder: (context) {
            return showErrorMessage(
                context, _gameStore.errorStore.errorMessage);
          },
        ),
      ]),
    );
  }
}
