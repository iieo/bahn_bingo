import 'dart:async';

import 'package:bahn_bingo/core/stores/error/error_store.dart';
import 'package:bahn_bingo/core/stores/form/create_game_store.dart';
import 'package:bahn_bingo/core/stores/form/game_error_store.dart';
import 'package:bahn_bingo/core/stores/form/join_game_store.dart';
import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/core/stores/language/language_store.dart';
import 'package:bahn_bingo/core/stores/theme/theme_store.dart';
import 'package:bahn_bingo/domain/repository/setting/setting_repository.dart';
import 'package:bahn_bingo/domain/usecase/game/call_bingo_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/create_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/exit_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/is_game_finished_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/join_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/load_game_usecase.dart';
import 'package:bahn_bingo/domain/usecase/game/toggle_event_usecase.dart';
import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => GameErrorStore());
    getIt.registerFactory(
      () => JoinGameStore(getIt<GameErrorStore>(), getIt<ErrorStore>()),
    );
    getIt.registerFactory(() => CreateGameStore(
          getIt<GameErrorStore>(),
          getIt<ErrorStore>(),
        ));

    // stores:------------------------------------------------------------------

    getIt.registerSingleton<GameStore>(
      GameStore(
        getIt<JoinGameUseCase>(),
        getIt<CreateGameUseCase>(),
        getIt<LoadGameUseCase>(),
        getIt<ExitGameUseCase>(),
        getIt<ToggleEventUseCase>(),
        getIt<CallBingoUseCase>(),
        getIt<IsGameFinishedUseCase>(),
        getIt<GameErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
