import 'package:firebase_notifications/notifications/domain/visitor/types/notification_type.dart';
import 'package:firebase_notifications/notifications/domain/visitor/types/notification_result.dart';
import 'package:firebase_notifications/notifications/domain/visitor/types/public_notification_type.dart';

abstract class NotificationVisitor {
  void visitPublic(PublicNotificationType type);
  void navigationPageAdded(NotificationResult type);

}