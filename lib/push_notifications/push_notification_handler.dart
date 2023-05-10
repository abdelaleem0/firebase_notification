import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/local_notification_service.dart';
import 'package:firebase_notifications/notifications/domain/visitor/types/notification_type.dart';
import 'package:firebase_notifications/notifications/domain/visitor/types/notification_result.dart';
import 'package:firebase_notifications/composition/on_click_notification.dart';
import 'package:firebase_notifications/push_notifications/notification_constans.dart';
import 'package:http/http.dart' as http;

///  Function [handleRemoteMessage]  call sometimes not all time
void handleRemoteMessage(RemoteMessage message) {
  final data = message.data;
  handleNotificationPressed(data);
}
///  Function [handleNotificationPressed]  call when you pressed on notification

/// [data] must be not Empty
void handleNotificationPressed(Map<String, dynamic> data) {
  if (data.isNotEmpty) {
    String type = data["type"];
    String content = data["content"];
    final NotificationType notificationType;
    notificationType =   NotificationResult(type, content);
    switch (type) {
      case 'Alert':
      /// this to push to any page you want
        OnClickNotificationEvent.pushUpdate(notificationType);
        print('notificationType is <<<<#>>>>$notificationType');

        break;

      default:
        return;
    }
  }else{
    /// this push to test , is [push] to page working or not ,
    /// but you must check if notification [data] is empty you must not push to  any page
    OnClickNotificationEvent.pushUpdate(const NotificationResult("test only","test only"));

  }


}

/// function [handleForegroundMessage] to appear notification
/// if you use notification from firebase only use [message.notification]
/// if you use notification from firebase and backend use[message.data]
void handleForegroundMessage(RemoteMessage message) async {
  final notification = message.notification;
  if (notification != null) {
    LocalNotificationService.instance.showNotificationWithPayload(
      id: message.notification.hashCode,
      title: message.notification?.title??'',
      body: message.notification?.body??'',
      payload: json.encode(message.data),
    );

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions();
    }
  }
}
/// function [pushNotification] to push notification to firebase
/// if you want to Uses this function you must change [token] to your device token and [key]
/// you key located in [project setting => Cloud messaging => Cloud Messaging API (Legacy) ] enable this key

Future<void> pushNotification({required String token, required String content}) async {
  try {
    await http.post(
      Uri.parse(NotificationsConstants.firebaseMessagingUri),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=${NotificationsConstants.firebaseMessagingKey}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'sound': 'default',
            'body': 'bodyyy',
            'title': 'title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'type': 'Alert',
            'content': content.isEmpty?'Welcome in Notification app ':content,
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    print("error push notification");
  }
}

