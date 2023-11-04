import 'package:another_flushbar/flushbar_helper.dart';
import 'package:bahn_bingo/constants/dimens.dart';
import 'package:bahn_bingo/core/stores/form/join_game_store.dart';
import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/core/widgets/button_widget.dart';
import 'package:bahn_bingo/core/widgets/empty_app_bar_widget.dart';
import 'package:bahn_bingo/core/widgets/input_widget.dart';
import 'package:bahn_bingo/core/widgets/progress_indicator_widget.dart';
import 'package:bahn_bingo/data/sharedpref/constants/preferences.dart';
import 'package:bahn_bingo/utils/device/device_utils.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class LoginGameScreen extends StatefulWidget {
  @override
  _LoginGameScreenState createState() => _LoginGameScreenState();
}

class _LoginGameScreenState extends State<LoginGameScreen> {
  //stores:---------------------------------------------------------------------
  final GameStore _gameStore = getIt<GameStore>();
  final JoinGameStore _formStore = getIt<JoinGameStore>();

  //text controllers:-----------------------------------------------------------
  final TextEditingController _gameIdController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _joinButtonFocusNode;

  @override
  void initState() {
    super.initState();
    _joinButtonFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: EmptyAppBar(),
        body: Stack(
          children: <Widget>[
            _buildContent(),
            Observer(
              builder: (context) {
                return _gameStore.game != null
                    ? navigate(context)
                    : _showErrorMessage(_formStore.errorStore.errorMessage);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(),
                  const SizedBox(
                    height: Dimens.vertical_padding,
                  ),
                  _buildInputUI(),
                ],
              )
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
          Text(AppLocalizations.of(context).translate('start_join_game_title'),
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
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 180.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Theme.of(context).colorScheme.background),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGameIdInputField(),
            const SizedBox(
              height: 20.0,
            ),
            AppButton(
              focusNode: _joinButtonFocusNode,
              type: ButtonType.PRIMARY,
              text: AppLocalizations.of(context).translate('join_game'),
              onPressed: () async {
                if (_formStore.canJoin) {
                  DeviceUtils.hideKeyboard(context);
                  _gameStore.joinGame(_gameIdController.text);
                } else {
                  _showErrorMessage(
                      "Error: " + _formStore.gameErrorStore.gameError!);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGameIdInputField() {
    return Observer(builder: (context) {
      return InputWidget(
        maxLength: 4,
        height: 78.0,
        inputType: TextInputType.emailAddress,
        icon: Icons.person,
        textController: _gameIdController,
        inputAction: TextInputAction.next,
        autoFocus: false,
        onChanged: (value) {
          _formStore.setGameId(_gameIdController.text);
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_joinButtonFocusNode);
        },
        errorText: _gameStore.gameErrorStore.gameError,
        topLabel: AppLocalizations.of(context).translate('game_id'),
        hintText: AppLocalizations.of(context).translate('enter_game_id'),
      );
    });
  }

  Widget navigate(BuildContext context) {
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
    _joinButtonFocusNode.dispose();
    _gameIdController.dispose();
    super.dispose();
  }
}
