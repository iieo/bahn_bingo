import 'package:bahn_bingo/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/game/game.dart';

class JoinGameUseCase implements UseCase<Game?, String> {
  final GameRepository _gameRepository;

  JoinGameUseCase(this._gameRepository);

  @override
  Future<Game?> call({required String params}) async {
    return await _gameRepository.joinGame(params);
  }
}
