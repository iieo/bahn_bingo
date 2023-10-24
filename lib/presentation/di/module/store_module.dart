import 'dart:async';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/create_game_store.dart';
import 'package:boilerplate/core/stores/form/game_error_store.dart';
import 'package:boilerplate/core/stores/form/join_game_store.dart';
import 'package:boilerplate/core/stores/game/game_store.dart';
import 'package:boilerplate/core/stores/language/language_store.dart';
import 'package:boilerplate/core/stores/theme/theme_store.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/exit_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/get_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/load_game_usecase.dart';
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
        getIt<GetGameUseCase>(),
        getIt<JoinGameUseCase>(),
        getIt<CreateGameUseCase>(),
        getIt<LoadGameUseCase>(),
        getIt<ExitGameUseCase>(),
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
