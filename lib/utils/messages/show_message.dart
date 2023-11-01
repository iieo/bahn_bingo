// General Methods:-----------------------------------------------------------
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

showErrorMessage(BuildContext context, String message) {
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
