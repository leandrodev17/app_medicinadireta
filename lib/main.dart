import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/modules/logs/controller/debug_view_controller.dart';
import 'package:medicinadireta/my_app_debug.dart';
import 'package:medicinadireta/my_app_prod.dart';
import 'core/failures/crashlytics/crashlytics_service.dart';
import 'core/widgets/app_log.dart';

/// Receive message when app is in background solution for on message
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppLog.w('###### MENSAGEM BACKGROUND ${message.messageId} #######');
}
//teste
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        return true;
      });
  }
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runZonedGuarded<Future<void>>(() async {
    await Future.wait([
      Firebase.initializeApp(),
      CrashlyticsService.initializeFlutterFire(),
      GetStorage.init(),
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
    ]);

    /// Notificação em background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(const MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        Get.put(DebugViewController());
        return const Visibility(
          visible: kReleaseDebugAPP,
          replacement: MyAppProd(),
          child: MyAppDebug(),
        );
      },
    );
  }
}
