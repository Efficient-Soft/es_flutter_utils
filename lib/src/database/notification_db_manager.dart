import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../models/notification_model.dart';

part 'notification_db_manager.g.dart';

Future<File> _getDatabaseFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final dbFile = File('${directory.path}/notification_db.sqlite');
  return dbFile;
}

@DriftDatabase(tables: [NotificationModelTable])
class NotificationDbManager extends _$NotificationDbManager {
  static final _db = NotificationDbManager._internal();
  factory NotificationDbManager() => _db;
  NotificationDbManager._internal()
      : super(LazyDatabase(() async => NativeDatabase(await _getDatabaseFile())));

  @override
  int get schemaVersion => 1;

  /// Insert or replace notification
  Future<void> saveNotification(NotificationModel notification) async {
    await into(notificationModelTable).insert(
      NotificationModelTableCompanion(
        messageId: Value(notification.messageId),
        sentTime: Value(notification.sentTime),
        title: Value(notification.title),
        body: Value(notification.body),
        redirectUrl: Value(notification.redirectUrl),
        type: Value(notification.type),
        jsonData: Value(
          notification.jsonData != null
              ? jsonEncode(notification.jsonData)
              : null,
        ),
        read: Value(notification.read),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> saveAllNotifications(
    Iterable<NotificationModel> notifications,
  ) async {
    if (notifications.isEmpty) return;
    await batch((batch) {
      batch.insertAll(
        notificationModelTable,
        notifications.map(
          (notification) => NotificationModelTableCompanion(
            messageId: Value(notification.messageId),
            sentTime: Value(notification.sentTime),
            title: Value(notification.title),
            body: Value(notification.body),
            redirectUrl: Value(notification.redirectUrl),
            type: Value(notification.type),
            jsonData: Value(
              notification.jsonData != null
                  ? jsonEncode(notification.jsonData)
                  : null,
            ),
            read: Value(notification.read),
          ),
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<NotificationModel?> getLatestNotification() async {
    final row = await (select(notificationModelTable)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.sentTime,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return NotificationModel(
      messageId: row.messageId,
      sentTime: row.sentTime,
      title: row.title,
      body: row.body,
      redirectUrl: row.redirectUrl,
      type: row.type,
      jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
      read: row.read,
    );
  }

  /// Get all notifications
  Future<List<NotificationModel>> getAllNotifications() async {
    final rows = await select(notificationModelTable).get();
    return rows.map((row) {
      return NotificationModel(
        messageId: row.messageId,
        sentTime: row.sentTime,
        title: row.title,
        body: row.body,
        redirectUrl: row.redirectUrl,
        type: row.type,
        jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
        read: row.read,
      );
    }).toList();
  }

  Future<Iterable<NotificationModel>> getUnreadNotifications({
    bool filterData = true,
  }) async {
    final rows = await (select(notificationModelTable)
          ..where(
            (tbl) => filterData
                ? tbl.read.equals(false) & tbl.jsonData.isNotNull()
                : tbl.read.equals(false),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.sentTime,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();

    return rows.map((row) {
      return NotificationModel(
        messageId: row.messageId,
        sentTime: row.sentTime,
        title: row.title,
        body: row.body,
        redirectUrl: row.redirectUrl,
        type: row.type,
        jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
        read: row.read,
      );
    });
  }

  Future<List<NotificationModel>> getTodayNewOrdersNotification({
    required RegExp match,
  }) async {
    final today = DateTime.now();
    final rows = await select(notificationModelTable).get();
    return rows
        .where(
          (noti) =>
              (noti.type?.contains(match) ?? false) &&
              (today.year == noti.sentTime.year &&
                  today.month == noti.sentTime.month &&
                  today.day == noti.sentTime.day),
        )
        .map((row) {
          return NotificationModel(
            messageId: row.messageId,
            sentTime: row.sentTime,
            title: row.title,
            body: row.body,
            redirectUrl: row.redirectUrl,
            type: row.type,
            jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
            read: row.read,
          );
        })
        .toList();
  }

  Stream<List<NotificationModel>> getAllNotificationsAsStream() {
    final streamList = select(notificationModelTable).watch();
    return streamList.map((rows) {
      return rows.map((row) {
        return NotificationModel(
          messageId: row.messageId,
          sentTime: row.sentTime,
          title: row.title,
          body: row.body,
          redirectUrl: row.redirectUrl,
          type: row.type,
          jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
          read: row.read,
        );
      }).toList();
    });
  }

  Future<List<NotificationModel>> deleteAll() async {
    final temp = await delete(notificationModelTable).goAndReturn();
    return temp.map((row) {
      return NotificationModel(
        messageId: row.messageId,
        sentTime: row.sentTime,
        title: row.title,
        body: row.body,
        redirectUrl: row.redirectUrl,
        type: row.type,
        jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
        read: row.read,
      );
    }).toList();
  }

  Future<List<NotificationModel>> deleteSelected(
    List<NotificationModel> notifications,
  ) async {
    if (notifications.isEmpty) return [];
    final ids = notifications.map((e) => e.messageId);

    final temp = await (delete(notificationModelTable)
          ..where((row) => row.messageId.isIn(ids)))
        .goAndReturn();

    return temp.map((row) {
      return NotificationModel(
        messageId: row.messageId,
        sentTime: row.sentTime,
        title: row.title,
        body: row.body,
        redirectUrl: row.redirectUrl,
        type: row.type,
        jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
        read: row.read,
      );
    }).toList();
  }

  Future<void> deleteNotification(String messageId) async {
    await (delete(notificationModelTable)
          ..where((tbl) => tbl.messageId.equals(messageId)))
        .go();
  }

  Future<void> markAsRead(Iterable<String> messageIds) async {
    if (messageIds.isEmpty) return;

    await (update(notificationModelTable)
          ..where((tbl) => tbl.messageId.isIn(messageIds)))
        .write(const NotificationModelTableCompanion(read: Value(true)));
  }

  /// Get all notifications
  Future<List<NotificationModel>> getTodaysNotifications() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    final streamRows = await (select(notificationModelTable)
          ..where(
            (tbl) => tbl.sentTime.isBetween(
              Variable(startOfDay),
              Variable(endOfDay),
            ),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.sentTime,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return streamRows.map((row) {
      return NotificationModel(
        messageId: row.messageId,
        sentTime: row.sentTime,
        title: row.title,
        body: row.body,
        redirectUrl: row.redirectUrl,
        type: row.type,
        jsonData: row.jsonData != null ? jsonDecode(row.jsonData!) : null,
        read: row.read,
      );
    }).toList();
  }
}
