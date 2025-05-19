import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_state.dart';

extension DaboardExtension on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(folders: ['1 Курс', '2 Курс']));

  void addFolder(String name) {
    emit(state.copyWith(folders: [...state.folders, name]));
  }

  static BlocProvider<DashboardCubit> provider() {
    return BlocProvider(create: (context) => DashboardCubit());
  }
}
