import 'package:firebase_notifications/notifications/domain/visitor/types/notification_type.dart';
import 'package:firebase_notifications/notifications/domain/visitor/notification_visitor.dart';

class NotificationResult extends NotificationType {
  final String type;
  final String content;

  const NotificationResult(this.type, this.content);

  @override
  List<Object?> get props => [type, content];

  @override
  void accept(NotificationVisitor visitor) {
    visitor.navigationPageAdded(this);
  }
}