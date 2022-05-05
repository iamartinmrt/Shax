import 'package:core/core.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shax/presentation/screen/auth/login/widgets/error_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax/presentation/shared_widgets/confirm_button.dart';
import 'package:shax/presentation/shared_widgets/email_field.dart';
import 'package:shax/presentation/shared_widgets/password_field.dart';
import 'package:shax/redux/actions/navigation_actions.dart';
import 'package:shax/redux/states/app_state.dart';
import 'package:shax/presentation/bloc/authentication/login/bloc.dart';

import '../../../../redux/actions/user_actions.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ButtonState stateTextWithIcon = ButtonState.idle;
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

  late LoginBloc _loginBloc;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _loginBloc = DependencyProvider.get<LoginBloc>();

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => _loginBloc,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: _height,
            width: _width,
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
                        width: (_width * 0.7))
                  ),
                ),
                _formFields(_width),
                const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _formFields(_width){
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state){
          if(state.formStatus is FormSubmitting) {
            stateTextWithIcon = ButtonState.loading;
          }else if(state.formStatus is InitialFormStatus){
            stateTextWithIcon = ButtonState.idle;
          }else if(state.formStatus is SubmissionSuccess){
            stateTextWithIcon = ButtonState.success;
            _controllerPassword.clear;
            _controllerEmail.clear;
            /// StoreProvider.of<AppState>(context).dispatch(UpdateUserInfoAction(userToken: state.user!.token, id: state.user!.id, email: state.user!.email));
            StoreProvider.of<AppState>(context).dispatch(NavigateToDashboardScreenAction());
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
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: ErrorTextViewLogin(
                        formStatus: state.formStatus,
                      )
                  ),
                  Form(
                    key: _formKeyEmail,
                    child: EmailField(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      onChangeEditText: (value) => BlocProvider.of<LoginBloc>(context).add(LoginEmailChanged(email: value)),
                      controllerEmail: _controllerEmail,
                      validator: _emailFieldValidator,
                      focusNode: _emailNode,
                      nextFocusNode: _passNode,
                    ),
                  ),
                  Form(
                    key: _formKeyPass,
                    child: PasswordField(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      focusNode: _passNode,
                      controllerPassword: _controllerPassword,
                      validator: _passwordFieldValidator,
                      onChangeAction: (value) => BlocProvider.of<LoginBloc>(context).add(LoginPasswordChanged(password: value)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ConfirmButton(
                      idleText: "Login",
                      stateTextWithIcon: stateTextWithIcon,
                      onPressButton: (){
                        bool validateEmail = _formKeyEmail.currentState!.validate();
                        bool validatePass = _formKeyPass.currentState!.validate();
                        if(validateEmail && validatePass){
                          BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ElevatedButton(
                        onPressed: (){
                          StoreProvider.of<AppState>(context).dispatch(NavigateToSignUpAction());
                        },
                        // style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.white, onPrimary: Colors.black),
                        child: const Text(TextConstants.noAccountSignup)),
                  )
                ],
              ),
            ),
          );
        },
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
    }else if (value.length > 3){
      return null;
    }else {
      return TextConstants.passwordNotValid;
    }
  }

}
