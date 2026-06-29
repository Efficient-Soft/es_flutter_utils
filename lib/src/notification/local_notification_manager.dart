import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationManager {
  LocalNotificationManager._();

  static const androidDefaultIcon = '@mipmap/ic_launcher';
  static const androidFcmChannelId = 'com.quickfood.biker';
  static const androidFcmChannelName = "QuickFood's Biker notification";

  static const androidGeneralChannelId = 'qf_biker_geneal_channel_id';
  static const androidGeneralChannelName =
      'QuickFood Biker General Notifications';

  static final _plugin = FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> show({
    int id = 225,
    required String title,
    required String body,
    bool isNewOrderAlert = false,
  }) async {
    if (!_initialized) {
      await init();
    }
    _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: const AndroidNotificationDetails(
          androidGeneralChannelId,
          androidGeneralChannelName,
        ),
        iOS: DarwinNotificationDetails(
          sound: isNewOrderAlert ? 'qfsong.wav' : 'custom_alert.wav',
        ),
      ),
    );
  }

  static Future<void> init() async {
    if (_initialized) return;
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings(androidDefaultIcon),
        iOS: DarwinInitializationSettings(),
      ),
    );

    final androidResolver = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    androidResolver?.createNotificationChannel(
      const AndroidNotificationChannel(
        androidFcmChannelName,
        androidFcmChannelName,
        description: 'Biker Order Service',
        importance: Importance.low,
      ),
    );
    androidResolver?.createNotificationChannel(
      const AndroidNotificationChannel(
        androidGeneralChannelId,
        androidGeneralChannelName,
        description: 'General Notifications for QuickFood Biker App',
        importance: Importance.high,
      ),
    );

    _initialized = true;
  }
}
