import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kursovaya_notebook/feature/link/data/model/link_data_model.dart';
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

  /// Загружаем все предметы из коробки и сортируем по папкам
  void loadSubjects() {
    final subjects = subjectBox.values.toList();
    final folderMap = <String, List<Subject>>{};

    for (var subject in subjects) {
      // Предположим, что subject принадлежит одной папке по id
      final folderId =
          subject.id.split('-').first; // Пример: часть UUID или отдельное поле
      folderMap.putIfAbsent(folderId, () => []).add(subject);
    }

    emit(state.copyWith(foldersSubjects: folderMap));
  }

  /// Добавить предмет
  Future<void> addSubject(String folderId, String subjectName) async {
    final subject = Subject(
      id: "$folderId-${_uuid.v4()}", // Закодируем folderId в id
      name: subjectName,
      links: [],
    );
    await subjectBox.add(subject);
    loadSubjects();
  }

  /// Добавить ссылку к предмету
  Future<void> addLinkToSubject(
    String folderId,
    int subjectIndex,
    LinkData newLink,
  ) async {
    final subjects = state.getSubjectsByFolder(folderId);
    if (subjectIndex >= subjects.length) return;

    final subject = subjects[subjectIndex];
    final updatedLinks = List<LinkData>.from(subject.links)..add(newLink);
    final updatedSubject = subject.copyWith(links: updatedLinks);

    await subject.save(); // Или переустанови полностью, если используешь putAt

    final allSubjects = List<Subject>.from(subjectBox.values);
    final indexInBox = allSubjects.indexWhere((s) => s.id == subject.id);
    if (indexInBox != -1) {
      await subjectBox.putAt(indexInBox, updatedSubject);
    }

    loadSubjects();
  }

  /// Удалить ссылку
  Future<void> removeLinkFromSubject(
    String folderId,
    int subjectIndex,
    int linkIndex,
  ) async {
    final subjects = state.getSubjectsByFolder(folderId);
    if (subjectIndex >= subjects.length) return;

    final subject = subjects[subjectIndex];
    if (linkIndex >= subject.links.length) return;

    final updatedLinks = List<LinkData>.from(subject.links)
      ..removeAt(linkIndex);
    final updatedSubject = subject.copyWith(links: updatedLinks);

    final allSubjects = List<Subject>.from(subjectBox.values);
    final indexInBox = allSubjects.indexWhere((s) => s.id == subject.id);
    if (indexInBox != -1) {
      await subjectBox.putAt(indexInBox, updatedSubject);
    }

    loadSubjects();
  }

  /// Обновление преподавателя и аттестации
  void updateSubjectInfo(
    String folderId,
    int subjectIndex,
    String teacher,
    String assessmentType,
  ) {
    final subjects = state.getSubjectsByFolder(folderId);
    if (subjectIndex >= subjects.length) return;

    final subject = subjects[subjectIndex];
    final updatedSubject = subject.copyWith(
      teacher: teacher,
      assessmentType: assessmentType,
    );

    final allSubjects = List<Subject>.from(subjectBox.values);
    final indexInBox = allSubjects.indexWhere((s) => s.id == subject.id);
    if (indexInBox != -1) {
      subjectBox.putAt(indexInBox, updatedSubject);
    }

    loadSubjects();
  }

  void printAllSubjects() {
    print('Всего предметов в Hive: ${subjectBox.length}');
    for (var s in subjectBox.values) {
      print('Subject: ${s.name} (id: ${s.id}) — links: ${s.links}');
    }
  }

  static BlocProvider<SubjectCubit> provider(Box<Subject> box) {
    return BlocProvider(create: (context) => SubjectCubit(box));
  }
}
