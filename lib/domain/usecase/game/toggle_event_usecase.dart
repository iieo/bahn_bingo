import 'package:bahn_bingo/domain/entity/game/game.dart';
import 'package:bahn_bingo/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class ToggleEventRequest {
  final int index;
  final Game game;
  ToggleEventRequest(this.game, this.index);
}

class ToggleEventUseCase implements UseCase<Game?, ToggleEventRequest> {
  final GameRepository _gameRepository;

  ToggleEventUseCase(this._gameRepository);

  @override
  Future<Game?> call({required ToggleEventRequest params}) async {
    return await _gameRepository.toggleEvent(params);
  }
}
