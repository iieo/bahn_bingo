import 'package:bahn_bingo/domain/entity/game/game.dart';
import 'package:bahn_bingo/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class CreateGameUseCase implements UseCase<Game?, List<String>> {
  final GameRepository _gameRepository;

  CreateGameUseCase(this._gameRepository);

  @override
  Future<Game?> call({required List<String> params}) async {
    return await _gameRepository.createGame(params);
  }
}
