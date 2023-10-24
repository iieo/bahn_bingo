import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/core/stores/game/game_store.dart';
import 'package:boilerplate/core/widgets/button_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
              ),
              Text(AppLocalizations.of(context).translate('app_name'),
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  AppLocalizations.of(context).translate('app_name'),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  AppLocalizations.of(context).translate('app_description'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                // Let's create a generic button widget
                AppButton(
                  text: AppLocalizations.of(context).translate('join_game'),
                  type: ButtonType.PLAIN,
                  onPressed: () {
                    navigateJoinGame(context);
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                AppButton(
                  text: AppLocalizations.of(context).translate('create_game'),
                  type: ButtonType.PRIMARY,
                  onPressed: () {
                    navigateCreateGame(context);
                  },
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  void navigateJoinGame(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.joinGame, (Route<dynamic> route) => false);
    });
  }

  void navigateCreateGame(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.createGame, (Route<dynamic> route) => false);
    });
  }
}
