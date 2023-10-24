import 'package:boilerplate/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/game/game.dart';

class ExitGameUseCase implements UseCase<void, void> {
  final GameRepository _gameRepository;

  ExitGameUseCase(this._gameRepository);

  @override
  Future<void> call({required void params}) async {
    _gameRepository.removeGameId();
  }
}
