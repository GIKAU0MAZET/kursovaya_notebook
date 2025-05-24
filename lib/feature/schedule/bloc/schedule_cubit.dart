import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';

class ScheduleCubit extends Cubit<List<ScheduleEvent>> {
  final Box<ScheduleEvent> scheduleBox;

  ScheduleCubit(this.scheduleBox) : super([]) {
    _loadEvents();
  }

  void _loadEvents() {
    emit(scheduleBox.values.toList());
  }

  Future<void> addEvent(ScheduleEvent event) async {
    await scheduleBox.add(event);
    _loadEvents();
  }

  Future<void> removeEvent(String id) async {
    final keyToDelete = scheduleBox.keys.firstWhere(
      (key) => scheduleBox.get(key)?.id == id,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      await scheduleBox.delete(keyToDelete);
      _loadEvents();
    }
  }

  static BlocProvider<ScheduleCubit> provider(Box<ScheduleEvent> box) {
    return BlocProvider(create: (_) => ScheduleCubit(box));
  }
}
