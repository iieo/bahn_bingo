import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonType { PRIMARY, PLAIN }

class AppButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback onPressed;
  final String text;
  final FocusNode? focusNode;

  const AppButton({
    Key? key,
    required this.type,
    required this.onPressed,
    required this.text,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      focusNode: focusNode,
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(48.0),
        decoration: BoxDecoration(
          color: type == ButtonType.PLAIN
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: _boxShadow(context),
        ),
        child: Center(
          child: Text(text,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: type == ButtonType.PLAIN
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  )),
        ),
      ),
    );
  }

  List<BoxShadow> _boxShadow(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ];
    } else {
      return [];
    }
  }
}
