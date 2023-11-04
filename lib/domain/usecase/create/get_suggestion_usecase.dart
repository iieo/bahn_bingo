import 'package:bahn_bingo/domain/repository/game/game_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class GetSuggestionUseCase implements UseCase<String, void> {
  final GameRepository _gameRepository;

  GetSuggestionUseCase(this._gameRepository);

  @override
  Future<String> call({required void params}) {
    return _gameRepository.getSuggestion();
  }
}
