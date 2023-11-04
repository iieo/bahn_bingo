import 'dart:async';

import 'package:bahn_bingo/domain/repository/game/game_repository.dart';
import 'package:bahn_bingo/domain/usecase/create/get_suggestion_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/call_bingo_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/create_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/exit_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/is_game_finished_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/join_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/load_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/toggle_event_usecase.dart';

import '../../../di/service_locator.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // game:--------------------------------------------------------------------

    getIt.registerSingleton<JoinGameUseCase>(
      JoinGameUseCase(getIt<GameRepository>()),
    );

    getIt.registerSingleton<CreateGameUseCase>(
      CreateGameUseCase(getIt<GameRepository>()),
    );

    getIt.registerSingleton<LoadGameUseCase>(
      LoadGameUseCase(getIt<GameRepository>()),
    );
    getIt.registerSingleton<ExitGameUseCase>(
      ExitGameUseCase(getIt<GameRepository>()),
    );
    getIt.registerSingleton<ToggleEventUseCase>(
      ToggleEventUseCase(getIt<GameRepository>()),
    );
    getIt.registerSingleton<CallBingoUseCase>(
      CallBingoUseCase(getIt<GameRepository>()),
    );
    getIt.registerSingleton<IsGameFinishedUseCase>(
      IsGameFinishedUseCase(getIt<GameRepository>()),
    );
    getIt.registerSingleton<GetSuggestionUseCase>(
      GetSuggestionUseCase(getIt<GameRepository>()),
    );
  }
}
