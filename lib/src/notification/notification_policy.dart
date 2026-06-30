import 'package:es_flutter_utils/es_flutter_utils.dart';

abstract class NotificationPolicy {
  bool shouldSave(NotificationModel notification);
  bool shouldShowLocalNotification(NotificationModel notification);
  bool shouldPlayAlert(NotificationModel notification);
  String channelIdFor(NotificationModel notification);
  String? soundFor(NotificationModel notification);
}
