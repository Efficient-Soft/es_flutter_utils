import 'package:drift/drift.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import '../utils/common_utils.dart';

class NotificationModelTable extends Table {
  TextColumn get messageId => text().customConstraint('NOT NULL UNIQUE')();
  DateTimeColumn get sentTime => dateTime()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get redirectUrl => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get jsonData => text().nullable()();
  BoolColumn get read => boolean().withDefault(const Constant(false))();

  @override
  Set<Column>? get primaryKey => {messageId}; // Ensure unique messages
}

enum PaymentCallback {
  walletCallBack,
  creditCallBack,
  orderCallBack,
  repaymentCallback,
  statementCallback;

  static PaymentCallback? fromValue(String value) {
    if (value.contains(RegExp('WalletCallback', caseSensitive: false))) {
      return walletCallBack;
    } else if (value.contains(RegExp('CreditCallback', caseSensitive: false))) {
      return creditCallBack;
    } else if (value.contains(RegExp('OrderCallback', caseSensitive: false))) {
      return orderCallBack;
    } else if (value.contains(
      RegExp('RepaymentCallback', caseSensitive: false),
    )) {
      return repaymentCallback;
    } else if (value.contains(
      RegExp('StatementCallback', caseSensitive: false),
    )) {
      return statementCallback;
    } else {
      return null;
    }
  }
}

class NotificationModel {
  final String messageId;
  final DateTime sentTime;
  final String title;
  final String body;
  final String? redirectUrl;
  final String? type;
  final Map<String, dynamic>? jsonData;
  final bool read;

  PaymentCallback? get getPaymentCallback =>
      PaymentCallback.fromValue(type ?? '');
  bool get isNewOrderAlert =>
      title.contains(RegExp('New Order Alert', caseSensitive: false)) == true;

  NotificationModel({
    required this.messageId,
    required this.sentTime,
    required this.title,
    required this.body,
    required this.redirectUrl,
    required this.type,
    required this.jsonData,
    this.read = false,
  });

  factory NotificationModel.fromRemoteMessage(
    RemoteMessage message, {
    bool read = false,
  }) {
    final title =
        (message.data['title'] as String?) ?? message.notification?.title ?? '';
    final body =
        (message.data['body'] as String?) ?? message.notification?.body ?? '';
    final jsonData = mergeTwoMap(message.data, message.data['jsonData']);
    return NotificationModel(
      messageId: message.messageId ?? const Uuid().v4(),
      sentTime: message.sentTime ?? DateTime.now(),
      title: title,
      body: body,
      redirectUrl: message.data['redirectUrl'] as String?,
      type: message.data['type'] as String?,
      jsonData: jsonData,
      read: read,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'sentTime': sentTime.toIso8601String(),
      'title': title,
      'body': body,
      'redirectUrl': redirectUrl,
      'type': type,
      'jsonData': jsonData,
      'read': read,
    };
  }

  @override
  String toString() {
    return 'NotificationModel(messageId: $messageId, sentTime: $sentTime, title: $title, body: $body, redirectUrl: $redirectUrl, type: $type, jsonData: $jsonData, read: $read)';
  }
}
