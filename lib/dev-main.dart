import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shax/models/entities/app_data.dart';
import 'package:shax/models/entities/custom_theme_mode.dart';
import 'package:shax/notification/notification_manager.dart';
import 'package:shax/shax_app.dart';
import 'common/flavor/flavor.dart';
import 'common/flavor/flavor_config.dart';
import 'models/entities/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notification/firebase_options.dart';

NotificationManager notificationManager = NotificationManager();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await notificationManager.initialNotification();
  await Hive.initFlutter();
  _registerHiveAdapters();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ShaxApp(FlavorConfig(
    flavor: Flavor.DEV,
    name: "DEV",
  )));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // notificationManager.initialNotification();
  notificationManager.displayNotification(message);
  print("Handling a background message: ${message.messageId}");
}

void _registerHiveAdapters(){
  Hive.registerAdapter(AppDataAdapter());
  Hive.registerAdapter(CustomThemeModeAdapter());
  Hive.registerAdapter(UserAdapter());
}
