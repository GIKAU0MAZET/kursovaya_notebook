import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_state.dart';
import 'package:kursovaya_notebook/feature/folders/data/model/folder_model.dart';

extension DashboardExtension on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();
}

class DashboardCubit extends Cubit<DashboardState> {
  final Box<Folder> folderBox;

  DashboardCubit(this.folderBox)
    : super(DashboardState(folders: folderBox.values.toList())) {
    printAllFolders();
  }

  Future<void> addFolder(String name) async {
    final newFolder = Folder(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
    );
    await folderBox.add(newFolder);
    emit(state.copyWith(folders: folderBox.values.toList()));
    printAllFolders();
  }

  void printAllFolders() {
    print('Всего папок в Hive: ${folderBox.length}');
    for (var f in folderBox.values) {
      print('Folder: ${f.name} (id: ${f.id})');
    }
  }

  static BlocProvider<DashboardCubit> provider(Box<Folder> box) {
    return BlocProvider(create: (context) => DashboardCubit(box));
  }
}
