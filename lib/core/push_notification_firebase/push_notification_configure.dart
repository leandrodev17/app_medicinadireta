import 'dart:convert';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Push_notification_strategy/push_notification_factory.dart';

class PushNotificationConfigure {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static NotificationDetails? platformChannelSpecifics;

  Future<void> notificationRequestPermission() async {
    try {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

      AppLog.w('Permissão concedida pelo usuário: ${settings.authorizationStatus}');
    } on Exception catch (e) {
      AppLog.d('### PushNotificationService #### NÃO FOI POSSIVEL CONFIGURAR O PUSH NOTIFICATION $e');
    }
  }

  Future<void> generatorToken() async {
    try {
      FirebaseMessaging.instance.onTokenRefresh.listen((_token) async {
        final String? currentToken = await SharedPreferencesHelper().currentTokenNotification;
        if (currentToken != _token && _token.isNotEmpty) {
          AppLog.w('Token: $_token');
          await SharedPreferencesHelper().setCurrentTokenNotification(_token.toString());
        }
      }).onError((e) {
        AppLog.d('### onTokenRefresh onError Falha ao tentar gerar TOKEN $e');
      });

      FirebaseMessaging.instance.getToken().then((_token) async {
        final String? currentToken = await SharedPreferencesHelper().currentTokenNotification;
        AppLog.w('Token: ${currentToken != _token} $_token currentToken $currentToken');
        if (currentToken != _token && _token != null) {
          await SharedPreferencesHelper().setCurrentTokenNotification(_token.toString());
        }
      }).catchError((e) {
        AppLog.d('### Falha ao tentar gerar TOKEN $e');
      }).whenComplete(() => AppLog.i('Token com sucesso'));
    } on Exception catch (e) {
      AppLog.d('### generatorToken Falha ao tentar gerar TOKEN $e');
    }
  }

  Future<void> initialConfigPushNotification() async {
    try {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'push_notification_medicina_channel_id', // id
        'push_notification_medicina_channel_name', // title
        description: 'push_notification_medicina_channel_description', // description
        importance: Importance.high,
      );

      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
      final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription:channel.description,
        importance: Importance.high,
        priority: Priority.high,
        showWhen: false,
        color: Color(0xFF0C29D0),
        playSound: true,
        sound: RawResourceAndroidNotificationSound('noti_sound'),
        icon: 'secondary_icon',
        largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
      );
      const IOSNotificationDetails iOSNotificationDetails = IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
      platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSNotificationDetails);

      /// Exibe o modal para qualquer notificaçao recebida.
      /// Quando o clique acontece a função onSelectNotification será executada e ira aplicar a regra para o tipo da notificação recebida.
      /// Se o APP estiver em background acionará onMessageOpenedApp
      /// Se Estiver aberto acionará onSelectNotification.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        try {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null && !kIsWeb) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              platformChannelSpecifics,
              payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
            );
          }
        } on Exception catch (e) {
          throw Exception("Problema no onMessage $e");
        }
      });

      /// Ação executada quando o APP está em background e o clique na notificação.
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
        try {
          AppLog.s('Inicio onMessageOpenedApp');
          var _data = message?.data ?? null;
          if (_data != null) {
            AppLog.s('Valor onMessageOpenedApp: $_data');
            PushNotificationFactory.create(_data)..execute();
          }
        } on Exception catch (e) {
          throw Exception("Problema no onMessageOpenedApp $e");
        }
      });

      await FirebaseMessaging.instance.subscribeToTopic(ConstStrings.TOPICS_NOTIFICATION);
    } on Exception catch (e) {
      AppLog.d('InitialConfigPushNotification: $e');
    }
  }

  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    AppLog.i("IOS: onDidReceiveLocalNotification: $title");
    //  if (payload != null) PushNotificationFactory.create(jsonDecode(payload))..execute();
  }

  Future onSelectNotification(String? data) async {
    AppLog.i("onSelectNotification: $data");
    if (data != null) PushNotificationFactory.create(jsonDecode(data))..execute();
  }
}
