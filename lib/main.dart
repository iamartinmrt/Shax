import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shax/shax_app.dart';

import 'common/flavor/flavor.dart';
import 'common/flavor/flavor_config.dart';
import 'models/entities/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  runApp(ShaxApp(FlavorConfig(
    flavor: Flavor.DEV,
    name: "DEV",
  )));
}
