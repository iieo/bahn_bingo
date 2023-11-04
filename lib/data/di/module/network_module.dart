import 'package:bahn_bingo/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:bahn_bingo/core/data/network/dio/interceptors/logging_interceptor.dart';
import 'package:bahn_bingo/data/network/firebase/firebase_client.dart';
import 'package:bahn_bingo/data/network/firebase/firebase_game.dart';
import 'package:bahn_bingo/data/sharedpref/shared_preference_helper.dart';
import 'package:event_bus/event_bus.dart';

import '../../../di/service_locator.dart';

mixin NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async =>
            await getIt<SharedPreferenceHelper>().authToken,
      ),
    );

    // firebase client:-------------------------------------------------------------
    getIt.registerSingleton(FirebaseClient(getIt<SharedPreferenceHelper>()));
    getIt.registerSingleton(FirebaseGame(getIt<FirebaseClient>()));
  }
}
