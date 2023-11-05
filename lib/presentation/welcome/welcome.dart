import 'package:bahn_bingo/core/widgets/button_widget.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/routes/routes.dart';
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(55.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                            ),
                          ),
                        ),
                        Text(AppLocalizations.of(context).translate('app_name'),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.apply(
                                  color: Theme.of(context).colorScheme.primary,
                                ))
                      ])),
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
            child: ListView(
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
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.joinGame),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                AppButton(
                  text: AppLocalizations.of(context).translate('create_game'),
                  type: ButtonType.PRIMARY,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.createGame),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
