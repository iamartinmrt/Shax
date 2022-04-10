import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shax/presentation/bloc/splash/bloc.dart';
import 'package:shax/redux/actions/navigation_actions.dart';
import 'package:shax/redux/states/app_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    double _width = MediaQuery.of(context).size.width;
    return BlocProvider(
      lazy: false,
      create: (_) => DependencyProvider.get<SplashBloc>()..add(SplashFetchData()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state){
          if((state.formStatus is SubmissionSuccess) && (!state.isFailed)){
            StoreProvider.of<AppState>(context).dispatch(NavigateToDashboardScreenAction());
          }
        },
        builder: (context, state){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                AnimatedContainer(
                  curve: Curves.easeOutQuart,
                  duration: const Duration(seconds: 2),
                  width: state.isInitial == false ? (_width*0.9) : 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Hero(
                        tag: GeneralConstants.heroTagStarterLogo,
                        child: Image.asset(GeneralConstants.starterLogoImagePath, width: (_width*0.8))
                    ),
                  ),
                ),
                Visibility(
                  visible: state.isFailed,
                  child: Column(
                    children: [
                      const Text(TextConstants.connectionFailed),
                      ElevatedButton(
                        child: const Text(TextConstants.tryAgain),
                        onPressed: (){
                          BlocProvider.of<SplashBloc>(context).add(SplashFetchData());
                        },
                      )
                    ],
                  ),
                  replacement: const SpinKitThreeBounce(
                    color: Colors.blueAccent,
                    size: 25.0,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

}
