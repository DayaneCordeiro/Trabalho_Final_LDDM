import 'package:rest_manager/models/activity.model.dart';
import 'package:rest_manager/repositories/activity.dao.dart';
import 'package:rest_manager/repositories/activity.database.dart';

class ActivityRepository {
  static ActivityRepository _instance;
  ActivityRepository._();
  AppDatabase database;
  ActivityDao activityDao;

  static Future<ActivityRepository> getInstance() async {
    if (_instance != null) return _instance;
    _instance = ActivityRepository._();
    await _instance.init();
    return _instance;
  }

  Future<void> init() async {
    database = await $FloorAppDatabase.databaseBuilder('activity.db').build();
    activityDao = database.activityDao;
  }

  Future<List<Activity>> getAll() async {
    try {
      return await activityDao.getAll();
    } catch (e) {
      return List<Activity>();
    }
  }

  Future<bool> create(Activity p) async {
    try {
      await activityDao.insertActivity(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Activity p) async {
    try {
      await activityDao.updateActivity(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      Activity p = await activityDao.getActivityById(id);
      await activityDao.deleteActivity(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
