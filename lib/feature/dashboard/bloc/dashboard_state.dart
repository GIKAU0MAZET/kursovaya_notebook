import 'package:kursovaya_notebook/feature/folders/data/model/folder_model.dart';

class DashboardState {
  final List<Folder> folders;

  DashboardState({required this.folders});

  DashboardState copyWith({List<Folder>? folders}) {
    return DashboardState(folders: folders ?? this.folders);
  }
}
