import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_state.dart';
import 'package:kursovaya_notebook/feature/subjects/data/model/subject_model.dart';

extension SubjectExtension on BuildContext {
  SubjectCubit get dashboardCubit => read<SubjectCubit>();
}

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(const SubjectState());

  Future<void> addSubject(String folderId, String subjectName) async {
    try {
      emit(state.copyWith(isLoading: true));

      await Future.delayed(Duration(milliseconds: 300));

      final newMap = Map<String, List<Subject>>.from(state.foldersSubjects);
      newMap[folderId] = [
        ...newMap[folderId] ?? [],
        Subject(name: subjectName),
      ];

      emit(state.copyWith(foldersSubjects: newMap, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Ошибка при добавлении предмета: $e',
          isLoading: false,
        ),
      );
    }
  }

  void updateSubjectInfo(
    String folderId,
    int subjectIndex,
    String teacher,
    String assessmentType,
  ) {
    final newState = Map<String, List<Subject>>.from(state.foldersSubjects);
    final subject = newState[folderId]![subjectIndex];
    newState[folderId]![subjectIndex] = subject.copyWith(
      teacher: teacher,
      assessmentType: assessmentType,
    );
    emit(state.copyWith(foldersSubjects: newState));
  }

  static BlocProvider<SubjectCubit> provider() {
    return BlocProvider(create: (context) => SubjectCubit());
  }
}
