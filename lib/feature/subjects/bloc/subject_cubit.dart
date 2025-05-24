import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_state.dart';
import 'package:kursovaya_notebook/feature/subjects/data/model/subject_model.dart';
import 'package:uuid/uuid.dart';

extension SubjectExtension on BuildContext {
  SubjectCubit get subjectCubit => read<SubjectCubit>();
}

class SubjectCubit extends Cubit<SubjectState> {
  final Box<Subject> subjectBox;
  final _uuid = Uuid();

  SubjectCubit(this.subjectBox) : super(const SubjectState()) {
    loadSubjects();
  }

  void loadSubjects() {
    final subjects = subjectBox.values.toList();
    final folderMap = <String, List<Subject>>{};

    for (var subject in subjects) {
      final folderId =
          subject.links.isNotEmpty ? subject.links.first : "unknown";
      folderMap.putIfAbsent(folderId, () => []).add(subject);
    }

    emit(state.copyWith(foldersSubjects: folderMap));
  }

  Future<void> addSubject(String folderId, String subjectName) async {
    final subject = Subject(
      id: _uuid.v4(),
      name: subjectName,
      links: [folderId],
    );
    await subjectBox.add(subject);
    loadSubjects();
  }

  void updateSubjectInfo(
    String folderId,
    int subjectIndex,
    String teacher,
    String assessmentType,
  ) {
    final all = subjectBox.values.toList();
    final matching = all.where((s) => s.links.contains(folderId)).toList();

    if (subjectIndex < matching.length) {
      final subject = matching[subjectIndex];
      subject.teacher = teacher;
      subject.assessmentType = assessmentType;
      subject.save();

      loadSubjects();
    }
  }

  void printAllSubjects() {
    print('Всего предметов в Hive: ${subjectBox.length}');
    for (var s in subjectBox.values) {
      print('Subject: ${s.name} (id: ${s.id})');
    }
  }

  static BlocProvider<SubjectCubit> provider(Box<Subject> box) {
    return BlocProvider(create: (context) => SubjectCubit(box));
  }
}
