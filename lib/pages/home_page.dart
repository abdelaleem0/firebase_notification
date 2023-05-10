import 'dart:convert';
import 'package:firebase_notifications/notifications/domain/visitor/navigation/notification_navigation_visitor.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/composition/add_composition_subscription.dart';
import 'package:firebase_notifications/local_notification_service.dart';
import 'package:firebase_notifications/composition/on_click_notification.dart';
import 'package:firebase_notifications/push_notifications/push_notification_handler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initStateFunctionality();
  }

  void initStateFunctionality() async {
    AddCompositionSubscription()
        .composite
        .add(OnClickNotificationEvent.stream().listen((event) {
          final visitor = NotificationNavigationVisitor(context);
          event.accept(visitor);
        }));
    await LocalNotificationService.instance.initialize();
    _setupInteractedMessage();
  }

  late final String? token;

  Future<void> _setupInteractedMessage() async {
    FirebaseMessaging.instance.getInitialMessage().then((initialMessage) {
      if (initialMessage != null) {
        handleRemoteMessage(initialMessage);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleRemoteMessage(event);
    });

    token = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((event) {
      if (mounted) {
        handleForegroundMessage(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: "write your message ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(
                        color: Colors.red, width: 1, style: BorderStyle.none),
                  ),
                )),
            Center(
              child: TextButton(
                  onPressed: () {
                    pushNotification(
                        token: token ?? '', content: messageController.text).then((value) {
                      FocusScope.of(context).unfocus();
                      messageController.clear();
                    });
                  },
                  child: const Text("pushNotification")),
            )
          ],
        ));
  }
}
