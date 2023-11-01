import 'package:boilerplate/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class IsGameFinishedUseCase implements UseCase<bool, String> {
  final GameRepository _gameRepository;

  IsGameFinishedUseCase(this._gameRepository);

  @override
  Future<bool> call({required String params}) {
    return _gameRepository.isGameFinished(params);
  }
}
