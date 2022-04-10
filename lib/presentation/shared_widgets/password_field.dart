import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final EdgeInsets? padding;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final ValueChanged<String>? onChangeAction;
  final TextEditingController controllerPassword;
  final validator;

  const PasswordField({Key? key,
    this.padding,
    this.labelText,
    this.nextFocusNode,
    required this.focusNode,
    required this.onChangeAction,
  required this.controllerPassword,
  required this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        focusNode: focusNode,
        onFieldSubmitted: (v) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        controller: controllerPassword,
        obscureText: true,
        maxLines: 1,
        decoration: InputDecoration(
            labelText: labelText ?? 'Password',
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.security)
        ),
        validator: validator,
        onChanged: onChangeAction,
      ),
    );
  }

}
