import 'package:rest_manager/models/activity.model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ActivityDao {
  @Query('SELECT * FROM Activity')
  Future<List<Activity>> getAll();

  @Query("SELECT * from Activity where id = :id")
  Future<Activity> getActivityById(int id);

  @insert
  Future<int> insertActivity(Activity a);

  @update
  Future<int> updateActivity(Activity a);

  @delete
  Future<int> deleteActivity(Activity a);
}
