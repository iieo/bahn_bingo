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
          color: getButtonColor(context, type),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              color: getTextColor(context, type),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

Color getButtonColor(BuildContext context, ButtonType type) {
  switch (type) {
    case ButtonType.PRIMARY:
      return Theme.of(context).colorScheme.primary;
    case ButtonType.PLAIN:
      return Colors.white;
    default:
      return Theme.of(context).colorScheme.primary;
  }
}

Color getTextColor(BuildContext context, ButtonType type) {
  switch (type) {
    case ButtonType.PLAIN:
      return Theme.of(context).colorScheme.primary;
    case ButtonType.PRIMARY:
      return Colors.white;
    default:
      return Colors.white;
  }
}
