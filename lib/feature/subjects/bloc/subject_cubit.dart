import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_state.dart';

extension SubjectExtension on BuildContext {
  SubjectCubit get dashboardCubit => read<SubjectCubit>();
}

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(const SubjectState());

  Future<void> addSubject(String folderId, String subjectName) async {
    try {
      emit(state.copyWith(isLoading: true));

      await Future.delayed(Duration(milliseconds: 300)); // Имитация задержки

      final newMap = Map<String, List<String>>.from(state.foldersSubjects);
      newMap[folderId] = [...newMap[folderId] ?? [], subjectName];

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

  static BlocProvider<SubjectCubit> provider() {
    return BlocProvider(create: (context) => SubjectCubit());
  }
}
