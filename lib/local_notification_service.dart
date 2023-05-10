import 'dart:convert';
import 'package:firebase_notifications/push_notifications/push_notification_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'composition/on_click_notification.dart';

class LocalNotificationService {
  final composite = CompositeSubscription();

  LocalNotificationService.initiate();

  static final LocalNotificationService _instance =
      LocalNotificationService.initiate();

  static LocalNotificationService get instance => _instance;

  static final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _localNotificationService.initialize(

      settings,
      onDidReceiveNotificationResponse: _onDidReceiveLocalNotification,
    );



    /// function [getNotificationAppLaunchDetails] get notifications and
    /// check if Is the notification opened?
    /// => if not open , call [_onDidReceiveLocalNotification] again to push to page which you want
    final notificationAppLaunchDetails =
        await _localNotificationService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      NotificationResponse notificationResponses = const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification);
      _onDidReceiveLocalNotification(
          notificationAppLaunchDetails?.notificationResponse);
    }
  }

  void cancelAllNotifications() => _localNotificationService.cancelAll();

  void cancelNotification(int id) => _localNotificationService.cancel(id);

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher',
            playSound: true);

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  ///  function [_onDidReceiveLocalNotification] call when you pressed on notification
  /// this function call everytime you pressed on notification
  void _onDidReceiveLocalNotification(NotificationResponse? details) {


    if ((details?.payload??'').isNotEmpty) {
      final Map<String, dynamic>? data = json.decode(details?.payload ?? "");

      /// data must be not null t
      if (data != null ) {
        handleNotificationPressed(data);
      }else{

      }
    }  else{
      /// if payload is empty you mush not call  _handleNotificationPressed(data)



    }








  }




}
