// schedule_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';

class ScheduleCubit extends Cubit<List<ScheduleEvent>> {
  ScheduleCubit() : super([]);

  void addEvent(ScheduleEvent event) {
    emit([...state, event]);
  }

  void removeEvent(String id) {
    emit(state.where((e) => e.id != id).toList());
  }

  static BlocProvider<ScheduleCubit> provider() {
    return BlocProvider(create: (context) => ScheduleCubit());
  }
}
