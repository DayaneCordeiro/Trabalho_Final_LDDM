import 'dart:async';
import 'package:rest_manager/models/activity.model.dart';
import 'package:rest_manager/repositories/activity.dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'activity.database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Activity])
abstract class AppDatabase extends FloorDatabase {
  ActivityDao get activityDao;
}
