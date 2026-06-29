import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../models/mystate.dart';
import '../database/notification_db_manager.dart';
import 'local_fcm_token_retriever.dart';
import 'local_notification_manager.dart';
import '../models/notification_model.dart';
import '../utils/common_utils.dart';

class FcmNotificationV2Manager {
  FcmNotificationV2Manager._();
  static StreamSubscription? _onMsbCb;
  static StreamSubscription? _onMessageOpenSub;
  static final _notificationStreamController =
      StreamController<Iterable<NotificationModel>>.broadcast();
  static Stream<Iterable<NotificationModel>> get stream =>
      _notificationStreamController.stream;
  static final _notiDb = NotificationDbManager();
  static AppLifecycleListener? _appLifecycleListener;
  static const _iosNotificationChannel = MethodChannel(
    'quickfood_biker/ios_notifications',
  );

  static Future<void> registerCallbackForForeground() async {
    /// receive while app is foreground
    _onMsbCb ??= FirebaseMessaging.onMessage.listen((event) async {
      printLog('FCM -> ${event.toMap()}');
      if (_isValidRemoteMessage(event)) {
        // it is read.since it is from foreground
        final noti = NotificationModel.fromRemoteMessage(event);
        await _notiDb.saveNotification(noti);
        _emitNotification([noti]);
        LocalNotificationManager.show(
          title: noti.title,
          body: noti.body,
          isNewOrderAlert: noti.isNewOrderAlert,
        );
      }
    });

    /// which is when user tapp,but when app is killed
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (_isValidRemoteMessage(initial)) {
      final noti = NotificationModel.fromRemoteMessage(initial!);

      final todayNotis =
          (await NotificationDbManager().getTodaysNotifications())
              .map((e) => e.messageId)
              .toSet();
      if (todayNotis.contains(noti.messageId)) {
        return;
      }
      // which is not read yet.since app is only starting
      await NotificationDbManager().saveNotification(noti);
    }

    /// which is when user tapp,but app is alive
    _onMessageOpenSub ??= FirebaseMessaging.onMessageOpenedApp.listen((
      message,
    ) async {
      if (_isValidRemoteMessage(message)) {
        final noti = NotificationModel.fromRemoteMessage(message);
        final todayNotis =
            (await NotificationDbManager().getTodaysNotifications())
                .map((e) => e.messageId)
                .toSet();
        if (todayNotis.contains(noti.messageId)) {
          return;
        }
        await _notiDb.saveNotification(noti);
        _emitNotification([noti]);
      }
    });
    _appLifecycleListener ??= AppLifecycleListener(
      onResume: () async {
        /// iOS delivered notifications are the notifications still visible in
        /// Notification Center. They may or may not already exist in local DB,
        /// because iOS can display remote notifications even when Flutter did
        /// not get a chance to persist them.
        final deliveredNotifications = Platform.isAndroid
            ? List<NotificationModel>.empty(growable: false)
            : await syncNotificationFromIOS();

        /// Today DB notifications are the notifications that Flutter already
        /// persisted. Existing unread notifications should be emitted once when
        /// the app resumes, then marked as read because the user has opened the
        /// app.
        final todaysNotifications = await _notiDb.getTodaysNotifications();
        final existingIds = todaysNotifications
            .map((notification) => notification.messageId)
            .toSet();

        final unreadNotifications = todaysNotifications.where(
          (notification) => !notification.read,
        );

        /// Only save delivered notifications that are not already in DB.
        /// They are saved as read, because this resume sync is only recovering
        /// them after the user opened the app.
        final tempTitles = todaysNotifications.map((e) => e.title);
        final tempBodys = todaysNotifications.map((e) => e.body);

        final unsavedDeliveredNotifications = deliveredNotifications.where(
          (notification) =>
              !existingIds.contains(notification.messageId) &&
              (!tempTitles.contains(notification.title) ||
                  !tempBodys.contains(notification.body)),
        );

        final totalUnreadNotifications = [
          ...unreadNotifications,
          ...unsavedDeliveredNotifications,
        ]..sort((a, b) => b.sentTime.compareTo(a.sentTime));
        if (unsavedDeliveredNotifications.isNotEmpty) {
          await _notiDb.saveAllNotifications(unsavedDeliveredNotifications);
        }
        if (totalUnreadNotifications.isNotEmpty) {
          _emitNotification(totalUnreadNotifications);
        }
      },
    );
  }

  static void _emitNotification(Iterable<NotificationModel> notification) {
    _notificationStreamController.add(notification);
  }

  static Future<MyState<String>> getFCMtoken() async {
    try {
      final token =
          await FirebaseMessaging.instance.getToken() ??
          await LocalFcmTokenRetriever().get();
      if (token == null || token.isEmpty) {
        return MyState.error(
          'Google Play services missing or without correct permission.',
        );
      }
      printLog('FCM Token is -> $token');
      return MyState.success(token);
    } catch (e) {
      printLog(e);
      return MyState.error(
        'Google Play services missing or without correct permission.',
      );
    }
  }

  @pragma('vm:entry-point')
  static void registerCallbackForBackground() {
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMsg);
  }

  /// Reads notifications that are still visible in iOS Notification Center.
  ///
  /// This does not mean the notifications already exist in local DB. iOS can
  /// show APNs/FCM notifications while Flutter is suspended or killed, so this
  /// method is used as a recovery source on app resume.
  static Future<List<NotificationModel>> syncNotificationFromIOS() async {
    final result = await _iosNotificationChannel.invokeMethod<List<dynamic>>(
      'getDeliveredNotifications',
    );
    if (result == null) return [];
    final notiList = result.map(_notificationModelFromDeliveredMap).toList();
    return notiList;
  }

  static NotificationModel _notificationModelFromDeliveredMap(dynamic map) {
    final userInfo = Map<String, dynamic>.from(
      (map['userInfo'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value),
          ) ??
          const {},
    );
    userInfo.remove('aps');
    userInfo.remove('google.c.sender.id');
    userInfo.remove('google.c.a.e');
    userInfo.remove('google.c.fid');
    userInfo.remove('payload');
    userInfo.remove('presentAlert');
    userInfo.remove('NotificationId');
    userInfo.remove('presentBadge');
    userInfo.remove('presentSound');
    userInfo.remove('presentBanner');
    userInfo.remove('title');
    userInfo.remove('presentList');
    final identifier = map['identifier'] as String?;

    final messageId =
        (userInfo['gcm.message_id'] as String?) ??
        (userInfo['messageId'] as String?) ??
        identifier ??
        DateTime.now().microsecondsSinceEpoch.toString();
    userInfo.remove('gcm.message_id');

    final title = map['title'] as String? ?? userInfo['title'] as String? ?? '';
    final body = map['body'] as String? ?? userInfo['body'] as String? ?? '';
    final redirectUrl = userInfo['redirectUrl'] as String?;
    final type = userInfo['type'] as String?;
    final dateMillis = map['date'] as int?;
    return NotificationModel(
      messageId: messageId,
      sentTime: dateMillis == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(dateMillis),
      title: title,
      body: body,
      redirectUrl: redirectUrl,
      type: type,
      jsonData: userInfo,
      read: false,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _handleBackgroundMsg(RemoteMessage message) async {
  printLog('FCM -> ${message.toMap()}');
  if (!_isValidRemoteMessage(message)) {
    return;
  }
  final noti = NotificationModel.fromRemoteMessage(message);
  if (Platform.isAndroid && !noti.isNewOrderAlert) {
    LocalNotificationManager.show(title: noti.title, body: noti.body);
  }
  await NotificationDbManager().saveNotification(noti);
}

bool _isValidRemoteMessage(RemoteMessage? message) {
  if (message == null) {
    return false;
  }
  return message.notification != null || message.data.isNotEmpty;
}
