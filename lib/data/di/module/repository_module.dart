import 'dart:async';

import 'package:bahn_bingo/data/network/firebase/firebase_game.dart';
import 'package:bahn_bingo/data/repository/setting/setting_repository_impl.dart';
import 'package:bahn_bingo/data/repository/game/game_repository_impl.dart';
import 'package:bahn_bingo/data/sharedpref/shared_preference_helper.dart';
import 'package:bahn_bingo/domain/repository/setting/setting_repository.dart';
import 'package:bahn_bingo/domain/repository/game/game_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<GameRepository>(GameRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<FirebaseGame>(),
    ));
  }
}
