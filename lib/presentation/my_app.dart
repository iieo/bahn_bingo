import 'package:bahn_bingo/constants/app_theme.dart';
import 'package:bahn_bingo/constants/strings.dart';
import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/core/stores/language/language_store.dart';
import 'package:bahn_bingo/core/stores/theme/theme_store.dart';
import 'package:bahn_bingo/presentation/game_field/game_field.dart';
import 'package:bahn_bingo/presentation/welcome/welcome.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../di/service_locator.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final GameStore _gameStore = getIt<GameStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return ScreenUtilInit(
            designSize: const Size(375, 812),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              theme: _themeStore.darkMode
                  ? AppThemeData.darkThemeData
                  : AppThemeData.lightThemeData,
              routes: Routes.routes,
              locale: Locale(_languageStore.locale),
              supportedLocales: _languageStore.supportedLanguages
                  .map((language) => Locale(language.locale, language.code))
                  .toList(),
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                // Built-in localization of basic text for Cupertino widgets
                GlobalCupertinoLocalizations.delegate,
              ],
              home: _loadScreen(),
            ));
      },
    );
  }

  Widget _loadScreen() {
    return FutureBuilder(
      future: _gameStore.loadActiveGame(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return snapshot.hasData && (snapshot.data ?? false)
                ? GameFieldScreen()
                : WelcomeScreen();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
