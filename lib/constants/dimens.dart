import 'package:flutter/material.dart';

class Dimens {
  Dimens._();

  //for all screens
  static const double horizontal_padding = 24.0;
  static const double vertical_padding = 20.0;

  static const EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: Dimens.horizontal_padding,
    vertical: Dimens.vertical_padding,
  );
}
