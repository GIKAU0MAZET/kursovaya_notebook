import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_state.dart';
import 'package:kursovaya_notebook/feature/folders/data/model/folder_model.dart';

extension DashboardExtension on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(folders: []));

  void addFolder(String name) {
    final newFolder = Folder(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
    );
    emit(state.copyWith(folders: [...state.folders, newFolder]));
  }

  static BlocProvider<DashboardCubit> provider() {
    return BlocProvider(create: (context) => DashboardCubit());
  }
}
