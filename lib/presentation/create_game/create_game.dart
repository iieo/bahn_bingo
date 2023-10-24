import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/stores/form/create_game_store.dart';
import 'package:boilerplate/core/stores/game/game_store.dart';
import 'package:boilerplate/core/widgets/button_widget.dart';
import 'package:boilerplate/core/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/input_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class CreateGameScreen extends StatefulWidget {
  @override
  _CreateGameScreenState createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  //stores:---------------------------------------------------------------------
  final GameStore _gameStore = getIt<GameStore>();
  final CreateGameStore _eventsStore = getIt<CreateGameStore>();

  //text controllers:-----------------------------------------------------------
  final TextEditingController _gameEventController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _createButtonFocusNode;

  @override
  void initState() {
    super.initState();
    _createButtonFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        appBar: EmptyAppBar(),
        body: Stack(
          children: <Widget>[
            _buildContent(),
            Observer(
              builder: (context) {
                return _gameStore.game != null
                    ? navigate(context)
                    : _showErrorMessage(_eventsStore.errorStore.errorMessage);
              },
            ),
            Observer(
              builder: (context) {
                return Visibility(
                  visible: _gameStore.isLoading,
                  child: CustomProgressIndicatorWidget(),
                );
              },
            )
          ],
        ));
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
          bottom: false,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: 0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/images/washing_machine_illustration.png",
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(),
                  const SizedBox(
                    height: Dimens.vertical_padding,
                  ),
                  _buildInputUI(),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: Dimens.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              navigateBack();
            },
            child: const Icon(
              Ionicons.arrow_back_outline,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(AppLocalizations.of(context).translate('create_game_title'),
              style: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Colors.white,
                  )),
        ],
      ),
    );
  }

  Widget _buildInputUI() {
    return Flexible(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 180.0,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGameIdInputField(),
            const SizedBox(
              height: 20.0,
            ),
            Observer(
                builder: ((context) => AppButton(
                      focusNode: _createButtonFocusNode,
                      type: ButtonType.PRIMARY,
                      text:
                          AppLocalizations.of(context).translate('create_game'),
                      onPressed: () async {
                        if (_eventsStore.canCreateGame) {
                          DeviceUtils.hideKeyboard(context);
                          _gameStore.joinGame(_gameEventController.text);
                        } else {
                          _showErrorMessage("Error: " +
                              _eventsStore.gameErrorStore.gameError!);
                        }
                      },
                    )))
          ],
        ),
      ),
    );
  }

  Widget _buildGameIdInputField() {
    return Observer(builder: (context) {
      return InputWidget(
        inputType: TextInputType.emailAddress,
        icon: Icons.person,
        textController: _gameEventController,
        inputAction: TextInputAction.next,
        autoFocus: false,
        onChanged: (value) {
          _eventsStore.setCurrentEvent(_gameEventController.text);
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_createButtonFocusNode);
        },
        errorText: _gameStore.gameErrorStore.gameError,
        topLabel: AppLocalizations.of(context).translate('game_event'),
        hintText: AppLocalizations.of(context).translate('enter_game_event'),
      );
    });
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(Preferences.game_id, _gameEventController.text);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  void navigateBack() {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.welcome, (Route<dynamic> route) => false);
    });
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _createButtonFocusNode.dispose();
    _gameEventController.dispose();
    super.dispose();
  }
}
