// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ActivityDao _activityDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Activity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `actualTime` REAL, `missingTime` INTEGER, `percentage` REAL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ActivityDao get activityDao {
    return _activityDaoInstance ??= _$ActivityDao(database, changeListener);
  }
}

class _$ActivityDao extends ActivityDao {
  _$ActivityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityInsertionAdapter = InsertionAdapter(
            database,
            'Activity',
            (Activity item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'actualTime': item.actualTime,
                  'missingTime': item.missingTime,
                  'percentage': item.percentage
                }),
        _activityUpdateAdapter = UpdateAdapter(
            database,
            'Activity',
            ['id'],
            (Activity item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'actualTime': item.actualTime,
                  'missingTime': item.missingTime,
                  'percentage': item.percentage
                }),
        _activityDeletionAdapter = DeletionAdapter(
            database,
            'Activity',
            ['id'],
            (Activity item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'actualTime': item.actualTime,
                  'missingTime': item.missingTime,
                  'percentage': item.percentage
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Activity> _activityInsertionAdapter;

  final UpdateAdapter<Activity> _activityUpdateAdapter;

  final DeletionAdapter<Activity> _activityDeletionAdapter;

  @override
  Future<List<Activity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Activity',
        mapper: (Map<String, dynamic> row) => Activity(
            id: row['id'] as int,
            title: row['title'] as String,
            actualTime: row['actualTime'] as double,
            missingTime: row['missingTime'] as int,
            percentage: row['percentage'] as double));
  }

  @override
  Future<Activity> getActivityById(int id) async {
    return _queryAdapter.query('SELECT * from Activity where id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Activity(
            id: row['id'] as int,
            title: row['title'] as String,
            actualTime: row['actualTime'] as double,
            missingTime: row['missingTime'] as int,
            percentage: row['percentage'] as double));
  }

  @override
  Future<int> insertActivity(Activity a) {
    return _activityInsertionAdapter.insertAndReturnId(
        a, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateActivity(Activity a) {
    return _activityUpdateAdapter.updateAndReturnChangedRows(
        a, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteActivity(Activity a) {
    return _activityDeletionAdapter.deleteAndReturnChangedRows(a);
  }
}
