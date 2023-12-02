import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final double height;
  final String topLabel;
  final bool isObscure;
  final TextEditingController textController;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? errorText;
  final int? maxLength;

  const InputWidget({
    super.key,
    this.hintText,
    this.inputType,
    this.icon,
    this.maxLength,
    this.errorText,
    this.height = 48.0,
    this.topLabel = "",
    this.isObscure = false,
    required this.textController,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topLabel, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 12.0),
        Container(
          //height: ScreenUtil().setHeight(height),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: textController,
            keyboardType: inputType,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            autofocus: autoFocus,
            textInputAction: inputAction,
            obscureText: isObscure,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
            ],
            decoration: InputDecoration(
              prefixIcon: icon == null
                  ? null
                  : Icon(icon,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              errorText: errorText,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        )
      ],
    );
  }
}
