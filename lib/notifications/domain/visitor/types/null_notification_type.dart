import 'package:firebase_notifications/notifications/domain/visitor/types/notification_type.dart';
import 'package:firebase_notifications/notifications/domain/visitor/notification_visitor.dart';

class NullNotificationType extends NotificationType {
  @override
  void accept(NotificationVisitor visitor) {}
}