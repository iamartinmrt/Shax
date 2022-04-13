import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:redux/redux.dart';
import 'package:shax/di/dio_setting.dart';
import 'package:shax/presentation/screen/splash/splash_screen.dart';
import 'package:shax/redux/states/app_state.dart';
import 'package:core/core.dart';
import 'package:shax/redux/store.dart';
import 'common/flavor/flavor_banner.dart';
import 'common/flavor/flavor_config.dart';
import 'common/keys.dart';
import 'di/injection_container.dart';
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

  @override
  void initState(){
    InjectionContainer.register();
    _store = createStore(widget.flavorConfig).then((value) {
      DioCustomSetting.addInterceptor(value);
      return value;
    });

    super.initState();
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
            child: MaterialApp(
                  title: 'ShaX',
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
