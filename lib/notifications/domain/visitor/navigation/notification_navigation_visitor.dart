import 'package:firebase_notifications/notifications/domain/visitor/types/notification_result.dart';
import 'package:firebase_notifications/notifications/domain/visitor/types/public_notification_type.dart';
import 'package:firebase_notifications/notifications/domain/visitor/notification_visitor.dart';
import 'package:firebase_notifications/pages/notification_page.dart';
import 'package:flutter/material.dart';

class NotificationNavigationVisitor implements NotificationVisitor {
  final BuildContext context;

  NotificationNavigationVisitor(this.context);

  @override
  void navigationPageAdded(
      NotificationResult type) {
    print('push to page =========>>>>........');
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotificationPage(
      type: type.type,
      content: type.content,
    ),));
  }

  @override
  void visitPublic(PublicNotificationType type) {
    // implement visitPublic
  }
}
