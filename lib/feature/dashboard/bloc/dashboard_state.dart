class DashboardState {
  final List<String> folders;

  DashboardState({this.folders = const ['1 Курс', '2 Курс']});

  DashboardState copyWith({List<String>? folders}) {
    return DashboardState(folders: folders ?? this.folders);
  }
}
