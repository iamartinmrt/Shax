import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmailField extends StatelessWidget {
  final EdgeInsets? padding;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String? textValue;
  final ValueChanged<String>? onChangeEditText;
  final TextEditingController controllerEmail;
  final validator;

  const EmailField({Key? key,
    this.padding,
    this.textValue,
    this.nextFocusNode,
    required this.focusNode,
    required this.onChangeEditText,
    required this.controllerEmail,
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
        controller: controllerEmail,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.mail),
          border: const OutlineInputBorder(),
          labelText: textValue ?? TextConstants.email,
        ),
        validator: validator,
        onChanged: onChangeEditText,
      ),
    );
  }
}
