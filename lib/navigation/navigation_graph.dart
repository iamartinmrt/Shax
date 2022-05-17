import 'package:flutter/widgets.dart';
import 'package:shax/navigation/route/app_route.dart';

class NavigationGraph {
  final _map = <String, Route Function(RouteSettings)>{};

  /// This method receive a [Map] which contains multiple routes for screens and set into [_map]
  registerFeature(Map<String, Route Function(RouteSettings)> routes) {
    _map.addAll(routes);
  }

  Route getRoute(RouteSettings settings) {
    final route = _map[settings.name]!;
    return route.call(settings);
  }
}
