import 'package:bahn_bingo/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class CallBingoUseCase implements UseCase<bool, String> {
  final GameRepository _gameRepository;

  CallBingoUseCase(this._gameRepository);

  @override
  Future<bool> call({required String params}) {
    return _gameRepository.callBingo(params);
  }
}
