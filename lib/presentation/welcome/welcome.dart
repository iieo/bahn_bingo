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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 100.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cloth_faded.png"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/images/illustration.png",
                  scale: 1.1,
                ),
              ),
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
              color: AppColors.white[100],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  AppLocalizations.of(context).translate('app_name'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(19, 22, 33, 1),
                      ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  AppLocalizations.of(context).translate('app_description'),
                  style: TextStyle(
                    color: Color.fromRGBO(74, 77, 84, 1),
                    fontSize: 14.0,
                  ),
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
