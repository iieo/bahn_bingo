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
              ? Colors.white
              : Theme.of(context).colorScheme.primary,
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
          child: Text(text,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: type == ButtonType.PLAIN
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
        ),
      ),
    );
  }
}
