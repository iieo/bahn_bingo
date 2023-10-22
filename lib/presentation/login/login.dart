import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/button_widget.dart';
import 'package:boilerplate/core/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/input_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          _buildContent(),
          Observer(
            builder: (context) {
              return _userStore.success
                  ? navigate(context)
                  : _showErrorMessage(_formStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
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
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeader(),
                    const SizedBox(
                      height: Dimens.vertical_padding,
                    ),
                    _buildLoginUI(),
                  ],
                ),
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
          Text(AppLocalizations.of(context).translate('auth_login_title'),
              style: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Colors.white,
                  )),
        ],
      ),
    );
  }

  Widget _buildLoginUI() {
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
            // Lets make a generic input widget
            _buildEmailField(),
            const SizedBox(
              height: 25.0,
            ),
            _buildPasswordField(),
            Observer(builder: (builder) {
              return Visibility(
                  visible: !_userStore.isLogin,
                  child: Column(children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    _buildConfirmPasswordField()
                  ]));
            }),
            const SizedBox(
              height: 15.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  onPressed: () => _userStore.setIsLogin(!_userStore.isLogin),
                  child: Text(
                    _userStore.isLogin
                        ? AppLocalizations.of(context)
                            .translate('auth_register_now')
                        : AppLocalizations.of(context)
                            .translate('auth_login_now'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              TextButton(
                  onPressed: () => {},
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('auth_forgot_password'),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ]),
            const SizedBox(
              height: 20.0,
            ),
            Observer(
                builder: ((context) => AppButton(
                      type: ButtonType.PRIMARY,
                      text: _userStore.isLogin
                          ? AppLocalizations.of(context).translate('auth_login')
                          : AppLocalizations.of(context)
                              .translate('auth_register'),
                      onPressed: () async {
                        if (_formStore.canLogin) {
                          DeviceUtils.hideKeyboard(context);
                          _userStore.login(_userEmailController.text,
                              _passwordController.text);
                        } else {
                          _showErrorMessage(AppLocalizations.of(context)
                              .translate('auth_fill_all_fields'));
                        }
                      },
                    )))
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Observer(builder: (context) {
      return InputWidget(
        isObscure: true,
        icon: Icons.lock,
        textController: _passwordController,
        focusNode: _passwordFocusNode,
        errorText: _formStore.formErrorStore.password,
        onChanged: (value) {
          _formStore.setPassword(_passwordController.text);
        },
        topLabel: AppLocalizations.of(context).translate('password'),
        hintText:
            AppLocalizations.of(context).translate('auth_login_enter_password'),
      );
    });
  }

  Widget _buildConfirmPasswordField() {
    return Observer(builder: (context) {
      return InputWidget(
        isObscure: true,
        icon: Icons.lock,
        textController: _confirmPasswordController,
        focusNode: _confirmPasswordFocusNode,
        errorText: _formStore.formErrorStore.confirmPassword,
        onChanged: (value) {
          _formStore.setConfirmPassword(_confirmPasswordController.text);
        },
        topLabel: AppLocalizations.of(context).translate('password'),
        hintText:
            AppLocalizations.of(context).translate('auth_login_enter_password'),
      );
    });
  }

  Widget _buildEmailField() {
    return Observer(builder: (context) {
      return InputWidget(
        inputType: TextInputType.emailAddress,
        icon: Icons.person,
        textController: _userEmailController,
        inputAction: TextInputAction.next,
        autoFocus: false,
        onChanged: (value) {
          _formStore.setUserId(_userEmailController.text);
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        errorText: _formStore.formErrorStore.userEmail,
        topLabel: AppLocalizations.of(context).translate('auth_email'),
        hintText: AppLocalizations.of(context).translate('auth_enter_email'),
      );
    });
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
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
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
