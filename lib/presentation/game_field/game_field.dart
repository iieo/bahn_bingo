import 'package:boilerplate/core/stores/game/game_store.dart';
import 'package:boilerplate/core/stores/theme/theme_store.dart';
import 'package:boilerplate/core/widgets/button_widget.dart';
import 'package:boilerplate/core/widgets/event_list_item.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/messages/show_message.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GameFieldScreen extends StatefulWidget {
  const GameFieldScreen({super.key});

  @override
  State<GameFieldScreen> createState() => _GameFieldScreenState();
}

class _GameFieldScreenState extends State<GameFieldScreen> {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final GameStore _gameStore = getIt<GameStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('game_id_title') +
            " ${_gameStore.game?.id ?? 'error'}"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          PopupMenuButton(
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
                ),
              ];
            },
            onSelected: (value) {
              // Handle submenu item selection here
            },
            icon: Icon(Icons.more_vert),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
      body: Stack(children: [
        _gameStore.game == null
            ? Center(child: CircularProgressIndicator.adaptive())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGameFinished(),
                  _buildGrid(),
                  _buildTaskList(),
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

  Widget _buildGameFinished() {
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

  Widget _buildTaskList() {
    List<EventItem> eventItems = _gameStore.game?.events ?? [];
    return Expanded(
        child: ListView.builder(
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
    ));
  }

  Widget _buildGrid() {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gameStore.game?.fieldSize ?? 5,
                ),
                itemCount: (_gameStore.game?.fieldSize ?? 5) *
                    (_gameStore.game?.fieldSize ?? 5),
                itemBuilder: (context, index) =>
                    Observer(builder: (context) => _buildGridItem(index)))));
  }

  Widget _buildGridItem(int index) {
    EventItem item = _gameStore.game?.events[index] ??
        EventItem(task: "task", done: index % 3 == 0);
    Widget gridItem;
    if (item.done) {
      gridItem = Container(
          decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logo.png"),
        ),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ));
    } else {
      gridItem = Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Center(child: Text((index + 1).toString())));
    }
    return gridItem;
  }
}
