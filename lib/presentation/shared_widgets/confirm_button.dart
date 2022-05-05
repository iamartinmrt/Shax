import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ConfirmButton extends StatelessWidget {
  final Function onPressButton;
  final ButtonState stateTextWithIcon;
  final String? idleText;
  final Icon? idleIcon;
  final String? successText;
  final Icon? successIcon;
  final String? failureText;
  final Icon? failureIcon;

  const ConfirmButton({Key? key,
    this.idleIcon,
    this.idleText,
    this.successIcon,
    this.successText,
    this.failureIcon,
    this.failureText,
    required this.onPressButton,
    required this.stateTextWithIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTextWithIcon(
      state: stateTextWithIcon,
      onPress: onPressButton,
      idleText: idleText,
      idleIcon: idleIcon,
    );
  }

  Widget buildTextWithIcon({
    required onPress, required state,
    String? idleText, Icon? idleIcon,
    String? successText, Icon? successIcon,
    String? failureText, Icon? failureIcon,
  }) {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle:
      IconedButton(
          text: idleText ?? TextConstants.confirm,
          icon: idleIcon ?? const Icon(Icons.send, color: Colors.white),
          color: Colors.black),

      ButtonState.loading:
      const IconedButton(
          text: TextConstants.loading,
          color: Colors.black),

      ButtonState.fail:
      IconedButton(
          text: failureText ?? TextConstants.failed,
          icon: failureIcon ?? const Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),

      ButtonState.success:
      IconedButton(
          text: successText ?? TextConstants.success,
          icon: successIcon ?? const Icon(
            Icons.verified_user,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPress, state: state);
  }

}
