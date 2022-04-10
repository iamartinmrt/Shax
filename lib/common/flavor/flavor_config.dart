import 'flavor.dart';

class FlavorConfig {
  final Flavor flavor;
  final String name;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, required String name}) =>
      _instance = FlavorConfig._(flavor, name);

  FlavorConfig._(this.flavor, this.name);

  static FlavorConfig get instance => _instance!;

  static String envName() => _instance!.name;

  static bool isProd() => _instance!.flavor == Flavor.PROD;

  static bool isDev() => _instance!.flavor == Flavor.DEV;
}
