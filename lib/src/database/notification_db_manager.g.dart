// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_db_manager.dart';

// ignore_for_file: type=lint
class $NotificationModelTableTable extends NotificationModelTable
    with TableInfo<$NotificationModelTableTable, NotificationModelTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationModelTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _sentTimeMeta = const VerificationMeta(
    'sentTime',
  );
  @override
  late final GeneratedColumn<DateTime> sentTime = GeneratedColumn<DateTime>(
    'sent_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _redirectUrlMeta = const VerificationMeta(
    'redirectUrl',
  );
  @override
  late final GeneratedColumn<String> redirectUrl = GeneratedColumn<String>(
    'redirect_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jsonDataMeta = const VerificationMeta(
    'jsonData',
  );
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
    'json_data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readMeta = const VerificationMeta('read');
  @override
  late final GeneratedColumn<bool> read = GeneratedColumn<bool>(
    'read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    messageId,
    sentTime,
    title,
    body,
    redirectUrl,
    type,
    jsonData,
    read,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_model_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationModelTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('sent_time')) {
      context.handle(
        _sentTimeMeta,
        sentTime.isAcceptableOrUnknown(data['sent_time']!, _sentTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_sentTimeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('redirect_url')) {
      context.handle(
        _redirectUrlMeta,
        redirectUrl.isAcceptableOrUnknown(
          data['redirect_url']!,
          _redirectUrlMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('json_data')) {
      context.handle(
        _jsonDataMeta,
        jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta),
      );
    }
    if (data.containsKey('read')) {
      context.handle(
        _readMeta,
        read.isAcceptableOrUnknown(data['read']!, _readMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  NotificationModelTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationModelTableData(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      sentTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_time'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      redirectUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}redirect_url'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      jsonData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_data'],
      ),
      read: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}read'],
      )!,
    );
  }

  @override
  $NotificationModelTableTable createAlias(String alias) {
    return $NotificationModelTableTable(attachedDatabase, alias);
  }
}

class NotificationModelTableData extends DataClass
    implements Insertable<NotificationModelTableData> {
  final String messageId;
  final DateTime sentTime;
  final String title;
  final String body;
  final String? redirectUrl;
  final String? type;
  final String? jsonData;
  final bool read;
  const NotificationModelTableData({
    required this.messageId,
    required this.sentTime,
    required this.title,
    required this.body,
    this.redirectUrl,
    this.type,
    this.jsonData,
    required this.read,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['sent_time'] = Variable<DateTime>(sentTime);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || redirectUrl != null) {
      map['redirect_url'] = Variable<String>(redirectUrl);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || jsonData != null) {
      map['json_data'] = Variable<String>(jsonData);
    }
    map['read'] = Variable<bool>(read);
    return map;
  }

  NotificationModelTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationModelTableCompanion(
      messageId: Value(messageId),
      sentTime: Value(sentTime),
      title: Value(title),
      body: Value(body),
      redirectUrl: redirectUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(redirectUrl),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      jsonData: jsonData == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonData),
      read: Value(read),
    );
  }

  factory NotificationModelTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationModelTableData(
      messageId: serializer.fromJson<String>(json['messageId']),
      sentTime: serializer.fromJson<DateTime>(json['sentTime']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      redirectUrl: serializer.fromJson<String?>(json['redirectUrl']),
      type: serializer.fromJson<String?>(json['type']),
      jsonData: serializer.fromJson<String?>(json['jsonData']),
      read: serializer.fromJson<bool>(json['read']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'sentTime': serializer.toJson<DateTime>(sentTime),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'redirectUrl': serializer.toJson<String?>(redirectUrl),
      'type': serializer.toJson<String?>(type),
      'jsonData': serializer.toJson<String?>(jsonData),
      'read': serializer.toJson<bool>(read),
    };
  }

  NotificationModelTableData copyWith({
    String? messageId,
    DateTime? sentTime,
    String? title,
    String? body,
    Value<String?> redirectUrl = const Value.absent(),
    Value<String?> type = const Value.absent(),
    Value<String?> jsonData = const Value.absent(),
    bool? read,
  }) => NotificationModelTableData(
    messageId: messageId ?? this.messageId,
    sentTime: sentTime ?? this.sentTime,
    title: title ?? this.title,
    body: body ?? this.body,
    redirectUrl: redirectUrl.present ? redirectUrl.value : this.redirectUrl,
    type: type.present ? type.value : this.type,
    jsonData: jsonData.present ? jsonData.value : this.jsonData,
    read: read ?? this.read,
  );
  NotificationModelTableData copyWithCompanion(
    NotificationModelTableCompanion data,
  ) {
    return NotificationModelTableData(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      sentTime: data.sentTime.present ? data.sentTime.value : this.sentTime,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      redirectUrl: data.redirectUrl.present
          ? data.redirectUrl.value
          : this.redirectUrl,
      type: data.type.present ? data.type.value : this.type,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      read: data.read.present ? data.read.value : this.read,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationModelTableData(')
          ..write('messageId: $messageId, ')
          ..write('sentTime: $sentTime, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('redirectUrl: $redirectUrl, ')
          ..write('type: $type, ')
          ..write('jsonData: $jsonData, ')
          ..write('read: $read')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    messageId,
    sentTime,
    title,
    body,
    redirectUrl,
    type,
    jsonData,
    read,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationModelTableData &&
          other.messageId == this.messageId &&
          other.sentTime == this.sentTime &&
          other.title == this.title &&
          other.body == this.body &&
          other.redirectUrl == this.redirectUrl &&
          other.type == this.type &&
          other.jsonData == this.jsonData &&
          other.read == this.read);
}

class NotificationModelTableCompanion
    extends UpdateCompanion<NotificationModelTableData> {
  final Value<String> messageId;
  final Value<DateTime> sentTime;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> redirectUrl;
  final Value<String?> type;
  final Value<String?> jsonData;
  final Value<bool> read;
  final Value<int> rowid;
  const NotificationModelTableCompanion({
    this.messageId = const Value.absent(),
    this.sentTime = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.redirectUrl = const Value.absent(),
    this.type = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.read = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationModelTableCompanion.insert({
    required String messageId,
    required DateTime sentTime,
    required String title,
    required String body,
    this.redirectUrl = const Value.absent(),
    this.type = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.read = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       sentTime = Value(sentTime),
       title = Value(title),
       body = Value(body);
  static Insertable<NotificationModelTableData> custom({
    Expression<String>? messageId,
    Expression<DateTime>? sentTime,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? redirectUrl,
    Expression<String>? type,
    Expression<String>? jsonData,
    Expression<bool>? read,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (sentTime != null) 'sent_time': sentTime,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (redirectUrl != null) 'redirect_url': redirectUrl,
      if (type != null) 'type': type,
      if (jsonData != null) 'json_data': jsonData,
      if (read != null) 'read': read,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationModelTableCompanion copyWith({
    Value<String>? messageId,
    Value<DateTime>? sentTime,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? redirectUrl,
    Value<String?>? type,
    Value<String?>? jsonData,
    Value<bool>? read,
    Value<int>? rowid,
  }) {
    return NotificationModelTableCompanion(
      messageId: messageId ?? this.messageId,
      sentTime: sentTime ?? this.sentTime,
      title: title ?? this.title,
      body: body ?? this.body,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      type: type ?? this.type,
      jsonData: jsonData ?? this.jsonData,
      read: read ?? this.read,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (sentTime.present) {
      map['sent_time'] = Variable<DateTime>(sentTime.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (redirectUrl.present) {
      map['redirect_url'] = Variable<String>(redirectUrl.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (read.present) {
      map['read'] = Variable<bool>(read.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationModelTableCompanion(')
          ..write('messageId: $messageId, ')
          ..write('sentTime: $sentTime, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('redirectUrl: $redirectUrl, ')
          ..write('type: $type, ')
          ..write('jsonData: $jsonData, ')
          ..write('read: $read, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$NotificationDbManager extends GeneratedDatabase {
  _$NotificationDbManager(QueryExecutor e) : super(e);
  $NotificationDbManagerManager get managers =>
      $NotificationDbManagerManager(this);
  late final $NotificationModelTableTable notificationModelTable =
      $NotificationModelTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notificationModelTable];
}

typedef $$NotificationModelTableTableCreateCompanionBuilder =
    NotificationModelTableCompanion Function({
      required String messageId,
      required DateTime sentTime,
      required String title,
      required String body,
      Value<String?> redirectUrl,
      Value<String?> type,
      Value<String?> jsonData,
      Value<bool> read,
      Value<int> rowid,
    });
typedef $$NotificationModelTableTableUpdateCompanionBuilder =
    NotificationModelTableCompanion Function({
      Value<String> messageId,
      Value<DateTime> sentTime,
      Value<String> title,
      Value<String> body,
      Value<String?> redirectUrl,
      Value<String?> type,
      Value<String?> jsonData,
      Value<bool> read,
      Value<int> rowid,
    });

class $$NotificationModelTableTableFilterComposer
    extends Composer<_$NotificationDbManager, $NotificationModelTableTable> {
  $$NotificationModelTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentTime => $composableBuilder(
    column: $table.sentTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get redirectUrl => $composableBuilder(
    column: $table.redirectUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get read => $composableBuilder(
    column: $table.read,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationModelTableTableOrderingComposer
    extends Composer<_$NotificationDbManager, $NotificationModelTableTable> {
  $$NotificationModelTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentTime => $composableBuilder(
    column: $table.sentTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get redirectUrl => $composableBuilder(
    column: $table.redirectUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get read => $composableBuilder(
    column: $table.read,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationModelTableTableAnnotationComposer
    extends Composer<_$NotificationDbManager, $NotificationModelTableTable> {
  $$NotificationModelTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<DateTime> get sentTime =>
      $composableBuilder(column: $table.sentTime, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get redirectUrl => $composableBuilder(
    column: $table.redirectUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<bool> get read =>
      $composableBuilder(column: $table.read, builder: (column) => column);
}

class $$NotificationModelTableTableTableManager
    extends
        RootTableManager<
          _$NotificationDbManager,
          $NotificationModelTableTable,
          NotificationModelTableData,
          $$NotificationModelTableTableFilterComposer,
          $$NotificationModelTableTableOrderingComposer,
          $$NotificationModelTableTableAnnotationComposer,
          $$NotificationModelTableTableCreateCompanionBuilder,
          $$NotificationModelTableTableUpdateCompanionBuilder,
          (
            NotificationModelTableData,
            BaseReferences<
              _$NotificationDbManager,
              $NotificationModelTableTable,
              NotificationModelTableData
            >,
          ),
          NotificationModelTableData,
          PrefetchHooks Function()
        > {
  $$NotificationModelTableTableTableManager(
    _$NotificationDbManager db,
    $NotificationModelTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationModelTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationModelTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationModelTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<DateTime> sentTime = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> redirectUrl = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> jsonData = const Value.absent(),
                Value<bool> read = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationModelTableCompanion(
                messageId: messageId,
                sentTime: sentTime,
                title: title,
                body: body,
                redirectUrl: redirectUrl,
                type: type,
                jsonData: jsonData,
                read: read,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                required DateTime sentTime,
                required String title,
                required String body,
                Value<String?> redirectUrl = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> jsonData = const Value.absent(),
                Value<bool> read = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationModelTableCompanion.insert(
                messageId: messageId,
                sentTime: sentTime,
                title: title,
                body: body,
                redirectUrl: redirectUrl,
                type: type,
                jsonData: jsonData,
                read: read,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationModelTableTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationDbManager,
      $NotificationModelTableTable,
      NotificationModelTableData,
      $$NotificationModelTableTableFilterComposer,
      $$NotificationModelTableTableOrderingComposer,
      $$NotificationModelTableTableAnnotationComposer,
      $$NotificationModelTableTableCreateCompanionBuilder,
      $$NotificationModelTableTableUpdateCompanionBuilder,
      (
        NotificationModelTableData,
        BaseReferences<
          _$NotificationDbManager,
          $NotificationModelTableTable,
          NotificationModelTableData
        >,
      ),
      NotificationModelTableData,
      PrefetchHooks Function()
    >;

class $NotificationDbManagerManager {
  final _$NotificationDbManager _db;
  $NotificationDbManagerManager(this._db);
  $$NotificationModelTableTableTableManager get notificationModelTable =>
      $$NotificationModelTableTableTableManager(
        _db,
        _db.notificationModelTable,
      );
}
