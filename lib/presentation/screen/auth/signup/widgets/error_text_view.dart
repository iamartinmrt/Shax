import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorTextViewSignup extends StatelessWidget {
  final formStatus;
  String errorText = "";

  ErrorTextViewSignup({Key? key,
  required this.formStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(formStatus is SubmissionFailed) {
      errorText = formStatus.exception.toString();
    }
    if(formStatus is SubmissionSuccess){
      errorText = "";
    }
    return Text(errorText, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
  }
}
