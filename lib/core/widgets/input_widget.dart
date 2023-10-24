import 'package:flutter/material.dart';
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
        Text(topLabel),
        const SizedBox(height: 5.0),
        Container(
          height: ScreenUtil().setHeight(height),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: textController,
            keyboardType: inputType,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            maxLength: maxLength,
            autofocus: autoFocus,
            textInputAction: inputAction,
            obscureText: isObscure,
            decoration: InputDecoration(
              prefixIcon: icon == null
                  ? null
                  : Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              errorText: errorText,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}
