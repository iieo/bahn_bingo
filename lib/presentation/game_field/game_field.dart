import 'package:boilerplate/core/stores/game/game_store.dart';
import 'package:boilerplate/core/stores/theme/theme_store.dart';
import 'package:boilerplate/core/widgets/button_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

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
                  onTap: () {
                    _gameStore.exitGame();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGrid(),
          _buildTaskList(),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    List<EventItem> eventItems = _gameStore.game?.events ??
        [
          EventItem(task: "Fahrt wird auf dem Weg abgebrochen"),
          EventItem(task: "Die Lok brennt", done: true),
          EventItem(task: "Durchsage auf Bayerisch"),
          EventItem(task: "Zug fällt aus"),
          EventItem(task: "Klimaanlage defekt"),
          EventItem(task: "Türe defekt"),
          EventItem(task: "Toilette ist gesperrt"),
          EventItem(task: "Man steht 15 min im Nirgendwo"),
          EventItem(task: "Kind schreit im Zug")
        ];
    return Expanded(
        child: ListView.builder(
      itemCount: eventItems.length + 1,
      itemBuilder: (context, index) {
        if (index == eventItems.length) {
          return Container(
              margin:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: AppButton(
                text: AppLocalizations.of(context).translate('bingo'),
                type: ButtonType.PRIMARY,
                onPressed: _gameStore.callBingo,
              ));
        }
        return Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("14:33 - 14:50",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              Text(" | 2h 30min | 15 transfers",
                                  style: Theme.of(context).textTheme.labelSmall)
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 8.0),
                                width:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                height: 22.0,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)
                                          .translate("card_no") +
                                      " $index",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 8.0),
                                width:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                height: 22.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6F7968),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Text(
                                  "ICE 420",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(eventItems[index].task),
                        ])),
                Container(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: eventItems[index].done,
                        onChanged: null,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            eventItems[index].done
                                ? AppLocalizations.of(context)
                                    .translate("mark_uncomplete")
                                : AppLocalizations.of(context)
                                    .translate("mark_complete"),
                            style: Theme.of(context).textTheme.labelLarge,
                          ))
                    ],
                  ),
                )
              ],
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
                itemBuilder: (context, index) => _buildGridItem(index))));
  }

  Widget _buildGridItem(int index) {
    EventItem item = _gameStore.game?.events[index] ??
        EventItem(task: "task", done: index % 3 == 0);
    Widget gridItem;
    if (item.done) {
      gridItem = GestureDetector(
        onTap: () {},
        child: Container(
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
        )),
      );
    } else {
      gridItem = GestureDetector(
        onTap: () {},
        child: Container(
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
            child: Center(child: Text((index + 1).toString()))),
      );
    }
    return gridItem;
  }
}
