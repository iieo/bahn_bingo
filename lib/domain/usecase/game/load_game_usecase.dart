import 'package:boilerplate/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/game/game.dart';

class LoadGameUseCase implements UseCase<Game?, void> {
  final GameRepository _gameRepository;

  LoadGameUseCase(this._gameRepository);

  @override
  Future<Game?> call({required void params}) async {
    return await _gameRepository.loadActiveGame();
  }
}
