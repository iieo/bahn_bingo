import '../../../core/domain/usecase/use_case.dart';
import '../../repository/game/game_repository.dart';

class GetGameUseCase implements UseCase<bool, void> {
  final GameRepository _gameRepository;

  GetGameUseCase(this._gameRepository);

  @override
  Future<bool> call({required void params}) async {
    return await _gameRepository.gameId != null;
  }
}
