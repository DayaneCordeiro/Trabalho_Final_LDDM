import 'package:rest_manager/repositories/activity.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:rest_manager/models/activity.model.dart';
import '../app_status.dart';
part 'activity.controller.g.dart';

class ActivityController = _ActivityController with _$ActivityController;

abstract class _ActivityController with Store {
  ActivityRepository repository;
  _ActivityController() {
    _init();
  }

  Future<void> _init() async {
    repository = await ActivityRepository.getInstance();
    await getAll();
  }

  @observable
  AppStatus status = AppStatus.none;

  @observable
  ObservableList<Activity> list = ObservableList<Activity>();

  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      if (repository != null) {
        final allList = await repository.getAll();
        list.clear();
        list.addAll(allList);
      }
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> create(Activity p) async {
    status = AppStatus.loading;

    try {
      await repository.create(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> update(Activity p) async {
    status = AppStatus.loading;
    try {
      await repository.update(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      await repository.delete(id);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }
}
