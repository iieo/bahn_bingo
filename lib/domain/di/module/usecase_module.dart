import 'dart:async';

import 'package:boilerplate/domain/repository/game/game_repository.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/exit_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/get_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/load_game_usecase.dart';

import '../../../di/service_locator.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // game:--------------------------------------------------------------------

    getIt.registerSingleton<GetGameUseCase>(
      GetGameUseCase(getIt<GameRepository>()),
    );

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
  }
}
