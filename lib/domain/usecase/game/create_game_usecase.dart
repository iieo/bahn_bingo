import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:boilerplate/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class CreateGameUseCase implements UseCase<Game?, void> {
  final GameRepository _gameRepository;

  CreateGameUseCase(this._gameRepository);

  @override
  Future<Game?> call({required void params}) async {
    return await _gameRepository.createGame();
  }
}
