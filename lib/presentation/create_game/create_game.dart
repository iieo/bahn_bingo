import 'package:another_flushbar/flushbar_helper.dart';
import 'package:bahn_bingo/constants/dimens.dart';
import 'package:bahn_bingo/core/stores/form/create_game_store.dart';
import 'package:bahn_bingo/core/stores/game/game_store.dart';
import 'package:bahn_bingo/core/widgets/button_widget.dart';
import 'package:bahn_bingo/core/widgets/empty_app_bar_widget.dart';
import 'package:bahn_bingo/core/widgets/input_widget.dart';
import 'package:bahn_bingo/core/widgets/progress_indicator_widget.dart';
import 'package:bahn_bingo/utils/device/device_utils.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:bahn_bingo/utils/messages/show_message.dart';
import 'package:bahn_bingo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: EmptyAppBar(),
        body: Stack(
          children: <Widget>[
            _buildContent(),
            Observer(
              builder: (context) {
                return _gameStore.game != null
                    ? navigate(context)
                    : showErrorMessage(
                        context, _eventsStore.errorStore.errorMessage);
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
            Expanded(
                child: Container(
                    child: Column(
              children: [
                _buildAmountSlider(),
                const SizedBox(
                  height: 20,
                ),
                _buildGameEventInputField(),
                const SizedBox(
                  height: 20,
                ),
                _buildAddEventButton(),
                _buildEventList(),
              ],
            ))),
            Observer(
                builder: ((context) => AppButton(
                      focusNode: _createButtonFocusNode,
                      type: ButtonType.PRIMARY,
                      text:
                          AppLocalizations.of(context).translate('create_game'),
                      onPressed: () async {
                        if (_eventsStore.canCreateGame) {
                          DeviceUtils.hideKeyboard(context);
                          _gameStore.createGame(_eventsStore.events);
                        } else {
                          showErrorMessage(
                              context,
                              "Error: " +
                                  AppLocalizations.of(context).translate(
                                      'create_game_error_event_length'));
                        }
                      },
                    )))
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Observer(builder: (context) {
      return Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _eventsStore.events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_eventsStore.events[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _eventsStore.removeEvent(index);
                    },
                  ),
                );
              }));
    });
  }

  Widget _buildAddEventButton() {
    return AppButton(
        type: ButtonType.PLAIN,
        onPressed: () async {
          if (_eventsStore.canAddEvent) {
            DeviceUtils.hideKeyboard(context);
            _eventsStore.addEvent(_gameEventController.text);
            _gameEventController.clear();
          } else {
            showErrorMessage(
                context, "Error: " + _eventsStore.gameErrorStore.gameError!);
          }
        },
        text: AppLocalizations.of(context).translate('add_event'));
  }

  Widget _buildAmountSlider() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppLocalizations.of(context).translate('field_size') +
            ": " +
            _eventsStore.fieldSize.toString(),
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      Observer(builder: (context) {
        return Slider(
          value: _eventsStore.fieldSize.toDouble(),
          min: 3,
          max: 5,
          divisions: 2,
          label: AppLocalizations.of(context).translate('field_size') +
              ": " +
              _eventsStore.fieldSize.toString(),
          onChanged: (double value) {
            _eventsStore.setFieldSize(value.toInt());
          },
        );
      })
    ]);
  }

  Widget _buildGameEventInputField() {
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

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _createButtonFocusNode.dispose();
    _gameEventController.dispose();
    super.dispose();
  }
}
