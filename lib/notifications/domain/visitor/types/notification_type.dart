import 'package:equatable/equatable.dart';
import 'package:firebase_notifications/notifications/domain/visitor/notification_visitor.dart';

abstract class NotificationType extends Equatable {
  const NotificationType();

  void accept(NotificationVisitor visitor);

  @override
  List<Object?> get props => [];
}




