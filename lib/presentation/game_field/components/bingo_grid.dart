import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/domain/entity/game/game.dart';
import 'package:bahn_bingo/presentation/game_field/components/bingo_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BingoGrid extends StatelessWidget {
  final GameStore _gameStore = getIt<GameStore>();
  BingoGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Game game = _gameStore.game ?? Game(id: 'error');
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: game.fieldSize,
        ),
        itemCount: game.fieldSize * game.fieldSize,
        itemBuilder: (context, index) => Observer(
            builder: (c) => BingoGridItem(
                item: game.events[index], cardNumber: index + 1)));
  }
}
