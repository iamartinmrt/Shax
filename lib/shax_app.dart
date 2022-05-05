import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:redux/redux.dart';
import 'package:shax/di/dio_setting.dart';
import 'package:shax/models/request/no_param_request.dart';
import 'package:shax/presentation/screen/splash/splash_screen.dart';
import 'package:shax/redux/actions/user_actions.dart';
import 'package:shax/redux/states/app_state.dart';
import 'package:core/core.dart';
import 'package:shax/redux/store.dart';
import 'common/flavor/flavor_banner.dart';
import 'common/flavor/flavor_config.dart';
import 'common/keys.dart';
import 'di/injection_container.dart';
import 'domain/usecase/local/get_user_local.dart';
import 'models/entities/user.dart';
import 'navigation/navigation_graph.dart';
import 'navigation/route/app_route.dart';

class ShaxApp extends StatefulWidget {
  final FlavorConfig flavorConfig;

  ShaxApp(this.flavorConfig,{Key? key}) : super(key: key);

  @override
  _ShaxAppState createState() => _ShaxAppState();
}

class _ShaxAppState extends State<ShaxApp> {
  late Future<Store<AppState>> _store;
  late GetUserLocal getUserLocal;

  @override
  void initState(){
    InjectionContainer.register();
    _store = createStore(widget.flavorConfig).then((value) {
      _getUserFromCacheInitial(value);
      DioCustomSetting.addInterceptor(value);
      return value;
    });

    super.initState();
  }

  void _getUserFromCacheInitial(Store<AppState> store){
    getUserLocal = DependencyProvider.get<GetUserLocal>();
    Result<User> result = getUserLocal(NoParamRequest());
    if(!result.isSuccess()){
      throw Exception("getLocalUser was not successful.");
    }
    store.dispatch((UpdateUserInfoAction(userToken: result.content!.token, id: result.content!.id, email: result.content!.email)));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return _addFlavorFlag(
      child: FutureBuilder<Store<AppState>>(
        future: _store,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            }
            return Container();
          }
          return StoreProvider<AppState>(
            store: snapshot.data!,
            child: StoreConnector<AppState, _ViewModel>(
              // rebuildOnChange: ,
              distinct: true,
              converter: _ViewModel.fromStore,
              builder: (context, vm) => MaterialApp(
                title: 'ShaX',
                theme: ThemeConstants.lightAppTheme,
                darkTheme: ThemeConstants.darkAppTheme,
                themeMode: vm.themeMode,
                debugShowCheckedModeBanner: false,
                navigatorKey: Keys.navigatorKey,
                initialRoute: AppRoute.splash,
                supportedLocales: const [Locale('en')],
                navigatorObservers: FlavorConfig.isDev() ?
                [NavigationHistoryObserver()] : [],
                onGenerateInitialRoutes: (name) => [
                  DependencyProvider.get<NavigationGraph>().getRoute(RouteSettings(name: name))
                ],
                onGenerateRoute: DependencyProvider.get<NavigationGraph>().getRoute,
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _addFlavorFlag({required Widget child}) {
    if (FlavorConfig.isProd()) {
      return child;
    }
    return FlavorBanner(
      child: child,
      color: Colors.yellow,
      bannerLocation: BannerLocation.bottomEnd,
    );
  }

}

class _ViewModel {
  ThemeMode themeMode;

  _ViewModel({
    required this.themeMode,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      themeMode: store.state.themeMode,
    );
  }
}

