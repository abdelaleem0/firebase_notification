import 'package:firebase_notifications/notifications/domain/visitor/types/notification_type.dart';
import 'package:rxdart/rxdart.dart';

class OnClickNotificationEvent {
  OnClickNotificationEvent._();

  static final _subject = PublishSubject<NotificationType>();

  static void pushUpdate(NotificationType notificationType) {
    _subject.add(notificationType);
  }

  static Stream<NotificationType> stream() {
    return _subject.stream;
  }
}