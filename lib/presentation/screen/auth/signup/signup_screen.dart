import 'package:core/core.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shax/presentation/bloc/authentication/signup/bloc.dart';
import 'package:shax/presentation/screen/auth/signup/widgets/error_text_view.dart';
import 'package:shax/presentation/shared_widgets/confirm_button.dart';
import 'package:shax/presentation/shared_widgets/email_field.dart';
import 'package:shax/presentation/shared_widgets/password_field.dart';
import 'package:shax/redux/actions/navigation_actions.dart';
import 'package:shax/redux/states/app_state.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  ButtonState stateTextWithIcon = ButtonState.idle;
  bool isEnterInfo = true;
  final _controllerEmail = TextEditingController();
  final _controllerCode = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerRepeatPassword = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKeyRePass = GlobalKey<FormState>();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  final FocusNode _rePassNode = FocusNode();

  late SignupBloc _signupBloc;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerCode.dispose();
    _controllerPassword.dispose();
    _controllerRepeatPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _signupBloc = DependencyProvider.get<SignupBloc>();

    _emailNode.addListener(() {
      if (!_emailNode.hasFocus) {
        _formKeyEmail.currentState!.validate();
      }
    });
    _passNode.addListener(() {
      if (!_passNode.hasFocus) {
        _formKeyPass.currentState!.validate();
      }
    });
    _rePassNode.addListener(() {
      if (!_rePassNode.hasFocus) {
        _formKeyRePass.currentState!.validate();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: buildBody(width, height),
    );
  }

  Widget buildBody(double width, double height){
    return BlocProvider(
      create: (_) => _signupBloc,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            width: width,
            child: Hero(
              tag: GeneralConstants.heroTagLoginBackground,
              child: Image.asset(GeneralConstants.loginBackgroundImagePath, fit: BoxFit.fill),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Hero(
                      tag: GeneralConstants.heroTagStarterLogo,
                      child: Image.asset(
                        GeneralConstants.starterLogoImagePath,
                        width: (width * 0.7))
                  ),
                ),
                _formFields(width),
                const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _formFields(_width){
    return BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state){
          if(state.formStatus is FormSubmitting) {
            stateTextWithIcon = ButtonState.loading;
          }else if(state.formStatus is InitialFormStatus){
            stateTextWithIcon = ButtonState.idle;
          }else if(state.formStatus is SubmissionSuccess){
            StoreProvider.of<AppState>(context).dispatch(NavigateToLoginAction());
            stateTextWithIcon = ButtonState.success;
            _controllerCode.clear;
          }else if(state.formStatus is SubmissionFailed){
            stateTextWithIcon = ButtonState.fail;
          }
        },
        builder: (context, state){
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            elevation: 3.0,
            child: Container(
              width: _width*0.9,
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(TextConstants.enterEmailPassword)
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: ErrorTextViewSignup(
                        formStatus: state.formStatus,
                      )
                  ),
                  Form(
                    key: _formKeyEmail,
                    child: EmailField(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      focusNode: _emailNode,
                      nextFocusNode: _passNode,
                      onChangeEditText: (value) => BlocProvider.of<SignupBloc>(context).add(SignupEmailChanged(value)),
                      controllerEmail: _controllerEmail,
                      validator: _emailFieldValidator,
                    ),
                  ),
                  Form(
                    key: _formKeyPass,
                    child: PasswordField(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      focusNode: _passNode,
                      labelText: TextConstants.password,
                      nextFocusNode: _rePassNode,
                      onChangeAction: (value) => BlocProvider.of<SignupBloc>(context).add(SignupPasswordChanged(value)),
                      controllerPassword: _controllerPassword,
                      validator: _passwordFieldValidator,
                    ),
                  ),
                  Form(
                    key: _formKeyRePass,
                    child: PasswordField(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      focusNode: _rePassNode,
                      labelText: TextConstants.repeatPassword,
                      onChangeAction: (value) => BlocProvider.of<SignupBloc>(context).add(SignupRepeatedPasswordChanged(value)),
                      validator: _rePasswordFieldValidator,
                      controllerPassword: _controllerRepeatPassword,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: ConfirmButton(
                        onPressButton: (){
                          bool validateEmail = _formKeyEmail.currentState!.validate();
                          bool validatePass = _formKeyPass.currentState!.validate();
                          bool validateRePass = _formKeyRePass.currentState!.validate();
                          if(validateEmail && validatePass && validateRePass){
                            BlocProvider.of<SignupBloc>(context).add(SignupSubmitted());
                          }
                        },
                        stateTextWithIcon: stateTextWithIcon,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ElevatedButton(
                        onPressed: (){
                          StoreProvider.of<AppState>(context).dispatch(NavigateToLoginAction());
                        },
                        style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.white, onPrimary: Colors.black),
                        child: const Text(TextConstants.noAccountLogin)),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  String? _emailFieldValidator(value){
    // if return null we say it's valid, else we return error string
    if(value == null || value == ""){
      return TextConstants.pleaseFillForm;
    }else if (EmailValidator.validate(value)){
      return null;
    }else {
      return TextConstants.emailNotValid;
    }
  }

  String? _passwordFieldValidator(value){
    // if return null we say it's valid, else we return error string
    if(value == null || value == ""){
      return TextConstants.pleaseFillForm;
    }else if (value.length <= 3){
      return TextConstants.passwordNotValid;
    }else {
      return null;
    }
  }

  String? _rePasswordFieldValidator(value){
    // if return null we say it's valid, else we return error string
    if(_controllerRepeatPassword.text != _controllerPassword.text){
      // _showSnackBar("Passwords doesn't match!");
      return TextConstants.passwordDoesNotMatch;
    }else {
      return null;
    }
  }

}

