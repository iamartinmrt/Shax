import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorTextViewLogin extends StatelessWidget {

  final formStatus;
  String errorText = "";

  ErrorTextViewLogin({Key? key,
  required this.formStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(formStatus is SubmissionFailed) {
      errorText = formStatus.exception.toString();
    }
    return Text(errorText, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
  }

}
