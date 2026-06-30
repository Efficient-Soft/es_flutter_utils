import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationConfig {
  final String androidDefaultIcon;
  final String androidFcmChannelId;
  final String androidFcmChannelName;
  final String androidGeneralChannelId;
  final String androidGeneralChannelName;

  const LocalNotificationConfig({
    this.androidDefaultIcon = '@mipmap/ic_launcher',
    this.androidFcmChannelId = 'default_fcm_channel_id',
    this.androidFcmChannelName = 'FCM Push Notifications',
    this.androidGeneralChannelId = 'default_general_channel_id',
    this.androidGeneralChannelName = 'General Notifications',
  });
}

class LocalNotificationManager {
  LocalNotificationManager._();

  static LocalNotificationConfig _config = const LocalNotificationConfig();
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static void configure(LocalNotificationConfig config) {
    _config = config;
  }

  static Future<void> show({
    int id = 225,
    required String title,
    required String body,
    String? iosSound,
  }) async {
    if (!_initialized) {
      await init();
    }
    _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _config.androidGeneralChannelId,
          _config.androidGeneralChannelName,
        ),
        iOS: DarwinNotificationDetails(sound: iosSound),
      ),
    );
  }

  static Future<void> init({LocalNotificationConfig? config}) async {
    if (config != null) {
      _config = config;
    }
    if (_initialized) return;
    await _plugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(_config.androidDefaultIcon),
        iOS: const DarwinInitializationSettings(),
      ),
    );

    final androidResolver = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidResolver?.createNotificationChannel(
      AndroidNotificationChannel(
        _config.androidFcmChannelName,
        _config.androidFcmChannelName,
        description: 'Order Service Notifications',
        importance: Importance.low,
      ),
    );
    await androidResolver?.createNotificationChannel(
      AndroidNotificationChannel(
        _config.androidGeneralChannelId,
        _config.androidGeneralChannelName,
        description: 'General application notifications',
        importance: Importance.high,
      ),
    );

    _initialized = true;
  }
}
