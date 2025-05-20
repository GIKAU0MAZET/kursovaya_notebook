import 'package:kursovaya_notebook/feature/subjects/data/model/subject_model.dart';

class SubjectState {
  final Map<String, List<Subject>> foldersSubjects;
  final bool isLoading;
  final String? error;

  List<Subject> getSubjectsByFolder(String folderId) {
    return foldersSubjects[folderId] ?? [];
  }

  const SubjectState({
    this.foldersSubjects = const {},
    this.isLoading = false,
    this.error,
  });

  SubjectState copyWith({
    Map<String, List<Subject>>? foldersSubjects,
    bool? isLoading,
    String? error,
  }) {
    return SubjectState(
      foldersSubjects: foldersSubjects ?? this.foldersSubjects,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
