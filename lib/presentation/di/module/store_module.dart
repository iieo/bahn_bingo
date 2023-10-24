import 'dart:async';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/stores/game/game_store.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/get_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/load_game_usecase.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/presentation/game_field/store/language/language_store.dart';
import 'package:boilerplate/presentation/game_field/store/theme/theme_store.dart';
import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => GameErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<GameErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------

    getIt.registerSingleton<GameStore>(
      GameStore(
        getIt<GetGameUseCase>(),
        getIt<JoinGameUseCase>(),
        getIt<CreateGameUseCase>(),
        getIt<LoadGameUseCase>(),
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
