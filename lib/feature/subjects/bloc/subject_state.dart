class SubjectState {
  final Map<String, List<String>> foldersSubjects;
  final bool isLoading;
  final String? error;
  List<String> getSubjectsByFolder(String folderId) {
    return foldersSubjects[folderId] ?? [];
  }

  const SubjectState({
    this.foldersSubjects = const {},
    this.isLoading = false,
    this.error,
  });

  SubjectState copyWith({
    Map<String, List<String>>? foldersSubjects,
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
