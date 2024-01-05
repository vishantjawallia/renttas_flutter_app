// ignore_for_file:  unused_local_variable, prefer_interpolation_to_compose_strings, camel_case_types, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';

import '../main.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: const Color(0xff54854C),
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
    FirebaseMessaging _messaging = FirebaseMessaging.instance;

    _messaging.getToken().then((token) {
      print("token===>  " + token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) {
      String token = value!;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text("notifcation".tr()),
      ),
      body: GlobalWidgets.notFound('notifcation'.tr()),
    );
  }
}
